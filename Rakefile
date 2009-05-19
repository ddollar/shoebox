require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Default: run unit tests.'
task :default => :spec

desc "Run all specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts  = ['--options', 'spec/spec.opts']
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov       = true
  t.rcov_dir   = 'coverage'
  t.rcov_opts = ['--exclude', '\/var\/lib\/gems,\/Library\/Ruby']
end

desc 'Generate documentation for the shoebox plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Shoebox'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
