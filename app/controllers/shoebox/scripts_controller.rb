class Shoebox::ScriptsController < ActionController::Base

  include Shoebox::Common

  def index
    buffer = Rails.cache.fetch(cache_key) { build } if Shoebox.config.cache
    render_buffer(buffer || build)
  end

private ######################################################################

  def controller
    params[:source_controller]
  end

  def cache_key
    controller
  end

  def build
    buffer = collapse_files(files)
    buffer = minify(buffer) if Shoebox.config.minify
    buffer
  end

  def collapse_files(files)
    files.inject('') do |buffer, file|
      buffer << File.read(file) << "\n"
    end
  end

  def files
    support_files(:scripts).select do |filename|
      File.dirname(filename).split('/').last == controller
    end
  end

  def mime_type
    'text/javascript'
  end

  def minify(buffer)
    Shoebox::Minifiers::Javascript.new(buffer).minify
  end

end
