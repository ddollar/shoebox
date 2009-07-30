module Shoebox::Helpers

  include Shoebox::Common

  def shoebox_scripts
    shoebox_scripts_tags(:application) +
    shoebox_scripts_tags(shoebox_controller)
  end

  def shoebox_styles(media = :screen)
    shoebox_styles_tags(:application, media) +
    shoebox_styles_tags(shoebox_controller, media)
  end

  def shoebox_scripts_tags(controller)
    if Rails.env.development?
      support_files(:scripts, controller).map do |full_filename|
        filename = File.basename(full_filename).split('.').first
        shoebox_scripts_tag(controller, filename)
      end.join
    else
      shoebox_scripts_tag(controller)
    end
  end

  def shoebox_scripts_tag(controller, filename=nil)
    src = shoebox_scripts_uri(controller, filename)
    %{ <script type="text/javascript" src="#{src}"></script> }
  end

  def shoebox_styles_tags(controller, media)
    if Rails.env.development?
      support_files(:styles, controller).map do |full_filename|
        filename = File.basename(full_filename).split('.').first
        shoebox_styles_tag(controller, media, filename)
      end.join
    else
      shoebox_styles_tag(controller, media)
    end
  end

  def shoebox_styles_tag(controller, media, filename=nil)
    href = shoebox_styles_uri(controller, media, filename)
    %{ <link type="text/css" rel="stylesheet" media="#{media}" href="#{href}" /> }
  end

  def shoebox_scripts_uri(controller, filename=nil)
    src  = "/shoebox/scripts/#{controller}"
    src += "/#{filename}" if filename
    src += ".js"
    src += "?#{Time.now.to_i}" if Rails.env.development?
    src
  end

  def shoebox_styles_uri(controller, media, filename=nil)
    src  = "/shoebox/styles/#{controller}/#{media}"
    src += "/#{filename}" if filename
    src += ".css"
    src += "?#{Time.now.to_i}" if Rails.env.development?
    src
  end

  def shoebox_controller
    controller.controller_name
  end

end
