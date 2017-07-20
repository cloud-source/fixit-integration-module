Rails.application.routes.draw do
  mount SampleIntegration::Engine => "/sample_integration"
end
