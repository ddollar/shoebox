require File.join(File.dirname(__FILE__), 'spec_helper')

describe Shoebox do

  it 'should be configurable' do
    Shoebox.config.should be_a(Shoebox::Configuration)
  end

end
