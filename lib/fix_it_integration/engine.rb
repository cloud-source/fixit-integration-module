module FixItIntegration
  class Engine < ::Rails::Engine
    isolate_namespace FixItIntegration
    config.generators.api_only = true
  end
end
