require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'fileutils'
require 'jeweler'
include FileUtils

require "lib/pitt"

NAME = "ppit"
task :default => [:test]

Rake::TestTask.new("test") do |t|
	t.libs   << "test"
	t.pattern = "test/**/*_test.rb"
	t.verbose = true
end

Jeweler::Tasks.new do |s|
  s.name = "pitt"
  s.summary = "pit wrapper: convert Hash keys which String to Symbol."
  s.email = "from.kyushu.island@gmail.com"
  s.homepage = "http://github.com/fkfk/pitt"
  s.description = s.summary
  s.author = "fkfk"
  s.add_dependency("pit")
end
