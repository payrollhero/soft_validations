# encoding: utf-8

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
  gem.name = "soft_validations"
  gem.homepage = "http://github.com/payrollhero/soft_validations"
  gem.license = "MIT"
  gem.summary = %Q{Provides an additional Errors object, referred to as warnings, to ActiveModel objects}
  gem.description = %Q{This gem provides an additional Errors object, referred to as warnings, to ActiveModel objects. The warnings object is not tied in to a model's life cycle. Thus, an ActiveModel object can be saved while still having messages in its warnings. This might be useful for sites that would want to keep track of recommended fields for users to complete, or sites with large amounts of erroneous imported data which might benefit from suspending some validations for a little while.}
  gem.email = "julia@github.com"
  gem.authors = ["Julia West", "Piotr Banasik", "Andrew Narkewicz"]
  # dependencies defined in Gemfile
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

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "soft_validations #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
