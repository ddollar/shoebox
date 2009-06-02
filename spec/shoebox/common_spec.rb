require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Shoebox::Common do

  before(:each) do
    @object = Object.new
    @object.extend Shoebox::Common
  end

  describe 'with #render_buffer' do

    it 'should render the buffer as text' do
      @object.should_receive(:mime_type).and_return('text/foo')
      @object.should_receive(:render).with(:text => 'foo', :content_type => 'text/foo')
      @object.render_buffer('foo')
    end

  end

end
