module Shoebox::Common

  def collapse_files(files)
    files.inject('') do |buffer, file|
      buffer << File.read(file) << "\n"
    end
  end

  def render_buffer(buffer)
    render :text => buffer
  end

  def support_files(type)
    Dir[File.join(Rails.root, 'app', type.to_s, '**', '*')]
  end

end
