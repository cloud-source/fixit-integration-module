$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sample_integration/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sample_integration"
  s.version     = SampleIntegration::VERSION
  s.authors     = ["Rafael Santos"]
  s.email       = ["rafael@thundermaps.com"]
  s.homepage    = "http://thundermaps.com"
  s.summary     = "Sample Integration for ThunderMaps"
  s.description = "Sample Integration to share data from/with Thundermaps."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.0.2"
  s.add_dependency 'httparty', '~> 0.14.0'
  s.add_development_dependency "pg"
  s.add_development_dependency "activerecord-postgis-adapter"
end
