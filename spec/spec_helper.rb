$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'shoebox'
require 'shoebox/common'
require 'shoebox/configuration'
require 'shoebox/helpers'
require 'shoebox/minifiers'
require 'shoebox/minifiers/css'
require 'shoebox/minifiers/javascript'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

module Rails
  def self.root
    File.join(File.dirname(__FILE__), 'fixtures')
  end
end

module ActionController
  class Base; end
end

require 'controllers/shoebox/scripts_controller'
require 'controllers/shoebox/styles_controller'
