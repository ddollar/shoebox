module Shoebox::Common

  def render_buffer(buffer)
    render :text => buffer, :content_type => mime_type
  end

  def support_files(type, controller)
    Dir[File.join(shoebox_base_path(type), controller.to_s, '*')]
  end

  def shoebox_base_path(type)
    File.join(Rails.root, 'app', type.to_s)
  end

end
