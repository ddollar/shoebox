ActionController::Routing::Routes.draw do |map|
  map.connect '/shoebox/scripts/:section.js',        :controller => 'shoebox/scripts'
  map.connect '/shoebox/styles/:section/:media.css', :controller => 'shoebox/styles'
end
