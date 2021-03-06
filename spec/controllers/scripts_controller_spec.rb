require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Shoebox::ScriptsController do

  before(:each) do
    Shoebox.config.reset
    @controller = Shoebox::ScriptsController.new
    @controller.stub(:render)
    @minifier_class = Shoebox::Minifiers::Javascript
  end

  describe 'with user controller' do

    before(:each) do
      @controller.stub('params').and_return({ :source_controller => 'users' })
    end

    it 'should render the user scripts' do
      @controller.should_receive(:render_buffer).with(/users.js/)
      @controller.index
    end

    it 'should not render the companies scripts' do
      @controller.should_not_receive(:render_buffer).with(/companies.js/)
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
      @controller.should_receive(:render_buffer).with(/users.js/)
      @controller.index
    end

    it 'should handle single files' do
      @controller.stub('params').and_return({ :source_controller => 'users', :filename => 'users-single' })
      @controller.should_receive(:render_buffer).with("users-single.js\n")
      @controller.index
    end

  end

end
