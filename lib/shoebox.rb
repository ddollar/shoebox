module Shoebox

  def self.config
    @config ||= Shoebox::Configuration.new
    yield @config if block_given?
    @config
  end

end
