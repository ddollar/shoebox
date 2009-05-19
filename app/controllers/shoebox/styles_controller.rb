class Shoebox::StylesController < ActionController::Base

  include Shoebox::Common

  def index
    buffer = collapse_files(files)
    buffer = minify(buffer) if Shoebox.config.minify
    render_buffer buffer
  end

private ######################################################################

  def controller
    params[:name]
  end

  def media
    params[:media]
  end

  def files
    support_files(:styles).select do |filename|
      dir  = File.dirname(filename).split('/').last
      name = File.basename(filename)

      next(false) unless [ 'application', controller ].include?(dir)

      case (parts = name.split('.')).length
        when 1 then raise "Unable to parse filename: #{filename}"
        when 2 then next(true)
        else        next(true) if parts[-2] == media.to_s
      end
    end
  end

  def minify(buffer)
    Shoebox::Minifiers::CSS.new(buffer).minify
  end

end
