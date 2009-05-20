require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Shoebox::Minifiers do

  describe Shoebox::Minifiers::CSS do

    it 'should minify css' do
      mini = Shoebox::Minifiers::CSS.new("body {\n  background-color: #eee;\n}")
      mini.minify.should =~ /background-color:#eee/
    end

  end

  describe Shoebox::Minifiers::Javascript do

    it 'should minify css' do
      mini = Shoebox::Minifiers::Javascript.new(" function() { alert('foo') } ")
      mini.minify.should =~ /function\(\)\{alert/
    end

  end

end
