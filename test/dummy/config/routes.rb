Rails.application.routes.draw do
  get 'dummy/dump' => 'application#dump'
  mount SampleIntegration::Engine => "/sample_integration"
end
