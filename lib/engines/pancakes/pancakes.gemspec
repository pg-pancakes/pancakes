$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pancakes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pancakes"
  s.version     = Pancakes::VERSION
  s.authors     = ["janko.marohnic@gmail.com", "stanko.krtalic@gmail.com", "marko.ivanek@gmail.com", "damir.svrtan@gmail.com"]
  s.email       = ["janko.marohnic@gmail.com", "stanko.krtalic@gmail.com", "marko.ivanek@gmail.com", "damir.svrtan@gmail.com"]
  s.homepage    = "https://github.com/railsrumble/r14-team-407"
  s.summary     = "Summary of Pancakes."
  s.description = "Description of Pancakes."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.6"
  s.add_dependency "net-ssh-gateway"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "font-awesome-sass"

  s.add_development_dependency "pg"
end
