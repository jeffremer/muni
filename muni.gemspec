# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "muni/version"

Gem::Specification.new do |s|
  s.name        = "muni"
  s.version     = Muni::VERSION
  s.authors     = ["Jeff Remer"]
  s.email       = ["jeff@threestarchina.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "muni"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "mash"
  s.add_dependency "xml-simple"
  s.add_dependency "actionpack"
  # For the executable
  s.add_dependency "thor"   
  
  s.add_development_dependency "rspec", "~> 2.0.0.beta.22"
end
