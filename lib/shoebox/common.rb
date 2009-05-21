module Shoebox::Common

  def render_buffer(buffer)
    render :text => buffer
  end

  def support_files(type)
    Dir[File.join(Rails.root, 'app', type.to_s, '**', '*')]
  end

end
