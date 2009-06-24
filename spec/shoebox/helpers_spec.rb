require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Shoebox::Helpers do

  before(:each) do
    @object = Object.new
    @object.extend Shoebox::Helpers
  end

  describe 'with #shoebox_scripts' do

    it 'should render appropriately' do
      @object.stub(:shoebox_controller).and_return('users')
      @object.shoebox_scripts.should include('/shoebox/scripts/application.js')
      @object.shoebox_scripts.should include('/shoebox/scripts/users.js')
    end

  end

  describe 'with #shoebox_styles' do

    it 'should render appropriately' do
      @object.stub(:shoebox_controller).and_return('users')
      @object.shoebox_styles.should include('/shoebox/styles/application/screen.css')
      @object.shoebox_styles.should include('/shoebox/styles/users/screen.css')
    end

    it 'should take media type as an arg' do
      @object.stub(:shoebox_controller).and_return('users')
      @object.shoebox_styles(:print).should include('/shoebox/styles/users/print.css')
    end

  end

end
