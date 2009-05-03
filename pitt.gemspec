# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pitt}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["fkfk"]
  s.date = %q{2009-05-04}
  s.description = %q{pit wrapper: convert Hash keys which String to Symbol.}
  s.email = %q{from.kyushu.island@gmail.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "Rakefile",
    "VERSION.yml",
    "lib/pitt.rb",
    "test/pitt_test.rb",
    "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/fkfk/pitt}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{pit wrapper: convert Hash keys which String to Symbol.}
  s.test_files = [
    "test/pitt_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pit>, [">= 0"])
    else
      s.add_dependency(%q<pit>, [">= 0"])
    end
  else
    s.add_dependency(%q<pit>, [">= 0"])
  end
end
