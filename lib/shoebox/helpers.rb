module Shoebox::Helpers

  def shoebox_scripts
    src = "/shoebox/styles/#{controller.controller_name}.js"
    tag 'script', { :type => 'text/javascript', :src => src  }
  end

  def shoebox_styles(media = :screen)
    href = "/shoebox/styles/#{controller.controller_name}/#{media}.css"
    tag 'link', { :rel => 'stylesheet', :href => href, :media => media }
  end
  
end