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

  s.files = Dir["{app,config,db,lib}/**/*", "COPYRIGHT", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.1"
end
