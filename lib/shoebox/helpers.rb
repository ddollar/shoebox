module Shoebox::Helpers

  def shoebox_scripts
    shoebox_scripts_tag(:application) +
    shoebox_scripts_tag(shoebox_controller)
  end

  def shoebox_styles(media = :screen)
    shoebox_styles_tag(:application, media) +
    shoebox_styles_tag(shoebox_controller, media)
  end

  def shoebox_scripts_tag(controller)
    src = shoebox_scripts_uri(controller)
    %{ <script type="text/javascript" src="#{src}"></script> }
  end

  def shoebox_styles_tag(controller, media)
    href = shoebox_styles_uri(controller, media)
    %{ <link type="text/css" rel="stylesheet" media="#{media}" href="#{href}" /> }
  end

  def shoebox_scripts_uri(controller)
    src  = "/shoebox/scripts/#{controller}.js"
    src += "?#{Time.now.to_i}" if Rails.env.development?
    src
  end

  def shoebox_styles_uri(controller, media)
    src  = "/shoebox/styles/#{controller}/#{media}.css"
    src += "?#{Time.now.to_i}" if Rails.env.development?
    src
  end

  def shoebox_controller
    controller.controller_name
  end

end
