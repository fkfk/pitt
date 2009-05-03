require "tmpdir"
require "pathname"

class Pathname
	@@tempname_number = 0
	def self.tempname(base=$0, dir=Dir.tmpdir)
		@@tempname_number += 1
		path = new(dir) + "#{File.basename(base)}.#{$$}.#{@@tempname_number}"
		at_exit do
			path.rmtree if path.exist?
		end
		path
	end
end

dir  = Pathname.tempname
dir.mkpath
ENV["HOME"] = dir

require File.dirname(__FILE__) + '/test_helper.rb'

require "test/unit"
class PittTest < Test::Unit::TestCase
	def test_load
		assert Pitt
	end

	def test_set_get
		Pitt.set("test", :data => {:username => "foo",:password => "bar"})
		assert_equal "foo", Pitt.get("test")[:username]
		assert_equal "bar", Pitt.get("test")[:password]

		Pitt.set("test2", :data => {:username => "foo2",:password => "bar2"})
		assert_equal "foo2", Pitt.get("test2")[:username]
		assert_equal "bar2", Pitt.get("test2")[:password]

		Pitt.set("test", :data => {:username => "foo",:password => "bar"})
		assert_equal "foo", Pitt.get("test")[:username]
		assert_equal "bar", Pitt.get("test")[:password]

		assert_equal "foo", Pitt.set("test", :data => {:username => "foo",:password => "bar"})[:username]
	end

	def test_editor
		ENV["EDITOR"] = nil
		assert_nothing_raised("When editor is not set.") do
			Pitt.set("test")
		end

		tst = Pathname.tempname
		exe = Pathname.tempname
		exe.open("w") do |f|
			f.puts <<-EOF.gsub(/^\t+/, "")
				#!/usr/bin/env ruby

				File.open(ENV["TEST_FILE"], "w") do |f|
					f.puts ARGF.read
				end
			EOF
		end
		exe.chmod(0700)

		ENV["TEST_FILE"] = tst.to_s
		ENV["EDITOR"]    = exe.to_s
		Pitt.set("test")

		assert_nothing_raised do
			assert_equal({}, YAML.load_file(tst.to_s))
		end

		data = {
			:foo => "0101",
			:bar => "0202",
		}

		Pitt.set("test", :data => data)
		Pitt.set("test")

		assert_nothing_raised do
			assert_equal(data, YAML.load_file(tst.to_s))
		end

		# clear
		Pitt.set("test", :data => {})
		#tst.open("w") {|f| }

		Pitt.get("test", :require => data)

		assert_nothing_raised do
			assert_equal(data, YAML.load_file(tst.to_s))
		end
	end

	def test_switch
		Pitt.switch("default")
		Pitt.set("test", :data => {:username => "foo",:password => "bar"})
		assert_equal "foo", Pitt.get("test")[:username]
		assert_equal "bar", Pitt.get("test")[:password]

		r = Pitt.switch("profile2")
		assert_equal "default", r
		assert_equal "profile2", Pitt.config["profile"]
		Pitt.set("test", :data => {:username => "foo2",:password => "bar2"})
		assert_equal "foo2", Pitt.get("test")[:username]
		assert_equal "bar2", Pitt.get("test")[:password]

		Pitt.switch("default")
		Pitt.set("test", :data => {:username => "foo",:password => "bar"})
		assert_equal "foo", Pitt.get("test")[:username]
		assert_equal "bar", Pitt.get("test")[:password]
	end
end
