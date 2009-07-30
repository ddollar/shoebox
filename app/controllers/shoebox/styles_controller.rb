class Shoebox::StylesController < ActionController::Base

  include Shoebox::Common

  def index
    buffer = Rails.cache.fetch(cache_key) { build } if Shoebox.config.cache
    render_buffer(buffer || build)
  end

private ######################################################################

  def controller
    params[:source_controller]
  end

  def media
    params[:media]
  end

  def cache_key
    "#{controller}.#{media}"
  end

  def build
    buffer = collapse_files(files)
    buffer = minify(buffer) if Shoebox.config.minify
    buffer
  end

  def collapse_files(files)
    files.inject('') do |buffer, file|
      data = File.read(file)
      buffer << case File.extname(file)
        when '.sass' then render_sass(data)
        when '.less' then render_less(data)
        else data
      end << "\n"
    end
  end

  def files
    support_files(:styles, controller).select do |filename|
      valid_file?(filename)
    end
  end

  def mime_type
    'text/css'
  end

  def minify(buffer)
    Shoebox::Minifiers::CSS.new(buffer).minify
  end

  def valid_file?(filename)
    name = File.basename(filename)

    return false unless File.dirname(filename).split('/').last == controller
    return false if params[:filename] && name.split('.').first != params[:filename]

    case (parts = name.split('.')).length
      when 1 then raise "Unable to parse filename: #{filename}"
      when 2 then return true
      else        return false unless parts[-2] == media.to_s
    end

    true
  end

private ######################################################################

  def load_paths
    [ File.join(shoebox_base_path(:styles), 'application'),
      File.join(shoebox_base_path(:styles), controller) ]
  end

  def render_less(data)
    require 'less'
    Less::Engine.new(data).to_css
  end

  def render_sass(data)
    require 'sass'
    Sass::Engine.new(data, :load_paths => load_paths).render
  end

end
