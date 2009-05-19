require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Shoebox::StylesController do

  before(:each) do
    @controller = Shoebox::StylesController.new
    @controller.stub(:render)
    @minifier_class = Shoebox::Minifiers::CSS
  end

  describe 'with user controller and screen media' do

    before(:each) do
      @controller.stub('params').and_return({ :name => 'users', :media => 'screen' })
    end

    it 'should render the application styles' do
      @controller.should_receive(:render_buffer).with(/application.css/)
      @controller.index
    end

    it 'should render the user styles' do
      @controller.should_receive(:render_buffer).with(/users.css/)
      @controller.index
    end

    it 'should not render the companies styles' do
      @controller.should_not_receive(:render_buffer).with(/companies.css/)
      @controller.index
    end

    it 'should render the screen styles' do
      @controller.should_receive(:render_buffer).with(/users.screen.css/)
      @controller.index
    end

    it 'should not render the print styles' do
      @controller.should_not_receive(:render_buffer).with(/users.print.css/)
      @controller.index
    end

    it 'should attempt to minify the output when the configuration is set' do
      Shoebox.config.minify = true
      minifier = mock(@minifier_class)
      minifier.should_receive(:minify)
      @minifier_class.should_receive(:new).and_return(minifier)
      @controller.index
    end

  end

end