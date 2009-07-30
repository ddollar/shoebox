ActionController::Routing::Routes.draw do |map|
  map.connect '/shoebox/scripts/:source_controller.js',        :controller => 'shoebox/scripts'
  map.connect '/shoebox/styles/:source_controller/:media.css', :controller => 'shoebox/styles'

  # single-file support
  map.connect '/shoebox/scripts/:source_controller/:filename.js',        :controller => 'shoebox/scripts'
  map.connect '/shoebox/styles/:source_controller/:media/:filename.css', :controller => 'shoebox/styles'
end
