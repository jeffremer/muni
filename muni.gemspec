# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "muni/version"

Gem::Specification.new do |s|
  s.name        = "muni"
  s.version     = Muni::VERSION
  s.authors     = ["Jeff Remer"]
  s.email       = ["jeff@threestarchina.com"]
  s.homepage    = "http://jeffremer.com/muni"
  s.summary     = %q{NextBus San Francisco Muni API Client}
  s.description = %q{A simple NextBus API client for retrieving San Francisco Muni bus route and stop prediction information}

  s.rubyforge_project = "muni"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "xml-simple"
  s.add_dependency "actionpack"
  s.add_dependency "amatch"
  s.add_dependency "thor"   # For the executable
  s.add_development_dependency "rspec", "~> 2"
  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr"
end
