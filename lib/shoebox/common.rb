module Shoebox::Common

  def render_buffer(buffer)
    render :text => buffer, :content_type => mime_type
  end

  def support_files(type)
    Dir[File.join(base_path(type), '**', '*')]
  end

  def base_path(type)
    File.join(Rails.root, 'app', type.to_s)
  end

end
