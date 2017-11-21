Rails.application.routes.draw do
  get 'dummy/dump' => 'application#dump'
  mount FixItIntegration::Engine => "/fix_it_integration"
end
