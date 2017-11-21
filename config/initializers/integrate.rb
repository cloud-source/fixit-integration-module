integrated_form_name = :fix_it_integration
Integrations.subscribe(:report_created_async) do |report|
  FixItIntegration.notify_report_creation(report)
end