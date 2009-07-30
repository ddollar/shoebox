require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Shoebox::StylesController do

  before(:each) do
    Shoebox.config.reset
    @controller = Shoebox::StylesController.new
    @controller.stub(:render)
    @minifier_class = Shoebox::Minifiers::CSS
  end

  describe 'with user controller and screen media' do

    before(:each) do
      @controller.stub('params').and_return({ :source_controller => 'users', :media => 'screen' })
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

    it 'should process sass files' do
      @controller.should_receive(:render_buffer).with(/background-color:\s*#000/)
      @controller.index
    end

    it 'should process sass imports' do
      @controller.should_receive(:render_buffer).with(/float:\simport_test/)
      @controller.index
    end

    it 'should process less files' do
      @controller.should_receive(:render_buffer).with(/border-bottom:\s*5px/)
      @controller.index
    end

    it 'should attempt to minify the output when the configuration is set' do
      Shoebox.config.minify = true
      minifier = mock(@minifier_class)
      minifier.should_receive(:minify)
      @minifier_class.should_receive(:new).and_return(minifier)
      @controller.index
    end

    it 'should cache when set' do
      Shoebox.config.cache = true
      @controller.index
      @controller.should_receive(:build).never
      @controller.should_receive(:render_buffer).with(/users.css/)
      @controller.index
    end

    it 'should handle single files' do
      @controller.stub('params').and_return({ :source_controller => 'users', :media => 'screen', :filename => 'users-single' })
      @controller.should_receive(:render_buffer).with("users-single.css\n")
      @controller.index
    end

  end

end
