class Shoebox::Configuration

  attr_accessor :cache
  attr_accessor :minify

  def initialize
    reset
  end

  def reset
    @cache  = false
    @minify = false
  end

end
