require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Shoebox::Configuration do

  before(:each) do
    @config = Shoebox::Configuration.new
  end

  it 'should have cache default to false' do
    @config.cache.should be_false
  end

  it 'should have minify default to false' do
    @config.minify.should be_false
  end

end
