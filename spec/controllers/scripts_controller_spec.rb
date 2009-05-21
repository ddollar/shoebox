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
      @controller.stub('params').and_return({ :name => 'users' })
    end

    it 'should render the application scripts' do
      @controller.should_receive(:render_buffer).with(/application.js/)
      @controller.index
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

  end

end
