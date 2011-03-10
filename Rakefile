require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "formtastic_validation"
  gem.homepage = "http://github.com/liangzan/formtastic_validation"
  gem.license = "MIT"
  gem.summary = %Q{Formtastic extension that does form validation}
  gem.description = %Q{Formtastic extension that does client side form validation}
  gem.email = "zan@liangzan.net"
  gem.authors = ["Wong Liang Zan"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
  gem.add_dependency "validation_reflection", "~> 1.0.0"
  gem.add_dependency "formtastic", "~> 1.2.0"
  gem.add_development_dependency "rails", "~> 3.0.0"
  gem.add_development_dependency "rspec", "~> 2.5.0"
  gem.add_development_dependency "rspec-rails", "~> 2.5.0"
  gem.add_development_dependency "rspec_tag_matchers", "= 1.0.0"
  gem.add_development_dependency "nokogiri", "~> 1.4.4"
  gem.add_development_dependency "activesupport", "~> 3.0.0"
  gem.add_development_dependency "actionpack", "~> 3.0.0"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "test #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
