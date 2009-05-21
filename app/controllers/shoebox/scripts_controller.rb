class Shoebox::ScriptsController < ActionController::Base

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

  def collapse_files(files)
    files.inject('') do |buffer, file|
      buffer << File.read(file) << "\n"
    end
  end

  def files
    support_files(:scripts).select do |filename|
      dir  = File.dirname(filename).split('/').last
      name = File.basename(filename)
      next([ 'application', controller ].include?(dir))
    end
  end

  def minify(buffer)
    Shoebox::Minifiers::Javascript.new(buffer).minify
  end

end
