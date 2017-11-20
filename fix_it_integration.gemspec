$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fix_it_integration/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fix_it_integration"
  s.version     = FixItIntegration::VERSION
  s.authors     = ["Chris Noldus"]
  s.email       = ["chris@thundermaps.com"]
  s.homepage    = "http:s//www.thundermaps.com"
  s.summary     = "Fix It Integration for ThunderMaps"
  s.description = "Fix it Integration to push data to FIX It Backend."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.0.2"
  s.add_dependency 'httparty', '~> 0.14.0'
  s.add_development_dependency "pg"
  s.add_development_dependency "activerecord-postgis-adapter"
end
