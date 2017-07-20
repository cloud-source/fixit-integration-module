module SampleIntegration
  class Engine < ::Rails::Engine
    isolate_namespace SampleIntegration
    config.generators.api_only = true
  end
end
