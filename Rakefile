require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'fileutils'
include FileUtils

require "lib/pitt"

NAME = "ppit"
task :default => [:test]

Rake::TestTask.new("test") do |t|
	t.libs   << "test"
	t.pattern = "test/**/*_test.rb"
	t.verbose = true
end
