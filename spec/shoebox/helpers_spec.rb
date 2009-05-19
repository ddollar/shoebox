require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Shoebox::Helpers do

  before(:each) do
    @object = Object.new
    @object.extend Shoebox::Helpers
    controller = mock
    controller.should_receive(:controller_name).and_return('users')
    @object.should_receive(:controller).and_return(controller)
  end

  describe 'with #shoebox_scripts' do

    it 'should render appropriately' do
      src = '/shoebox/styles/users.js'
      @object.should_receive(:tag).with('script', hash_including(:src => src))
      @object.shoebox_scripts
    end

  end

  describe 'with #shoebox_styles' do

    it 'should render appropriately' do
      href = '/shoebox/styles/users/screen.css'
      @object.should_receive(:tag).with('link', hash_including(:href => href))
      @object.shoebox_styles
    end

    it 'should take media type as an arg' do
      href = '/shoebox/styles/users/print.css'
      @object.should_receive(:tag).with('link', hash_including(:href => href))
      @object.shoebox_styles(:print)
    end

  end

end
