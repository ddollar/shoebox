$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'shoebox'
require 'shoebox/common'
require 'shoebox/configuration'
require 'shoebox/helpers'
require 'shoebox/minifiers'
require 'shoebox/minifiers/css'
require 'shoebox/minifiers/javascript'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

class RailsEnvironmentMock
  def development?
    false
  end
end

class RailsCacheMock
  def self.fetch(key)
    @cache ||= {}
    @cache[key] = yield unless @cache.has_key?(key)
    @cache[key]
  end
end

module Rails
  def self.cache
    RailsCacheMock
  end

  def self.env
    RailsEnvironmentMock.new
  end

  def self.root
    File.join(File.dirname(__FILE__), 'fixtures')
  end
end

module ActionController
  class Base; end
end

require 'controllers/shoebox/scripts_controller'
require 'controllers/shoebox/styles_controller'
