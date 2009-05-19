ActionController::Routing::Routes.draw do |map|
  map.connect '/shoebox/scripts/:name.js',        :controller => 'shoebox/scripts'
  map.connect '/shoebox/styles/:name/:media.css', :controller => 'shoebox/styles'
end
