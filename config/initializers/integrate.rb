# Integrations.register(:report_data, "Sample Report Data") do |report|
#   FixItIntegration.integrated_report_data(report)
# end

# integrated_form_name = :sample_integration
# Integrations.register(:report_form, integrated_form_name) do |report|
#   FixItIntegration.integrated_report_form(report)
# end

Integrations.subscribe(:report_created_sync) do |report|
  params = report.integrated_forms.try!(:[], integrated_form_name)
  FixItIntegration.create_integrated_report(report, params)
end

# Integrations.subscribe(:report_created_async) do |report|
#   SampleIntegration.notify_report_creation(report)
# end

# Integrations.register(:configuration_data, :sample_integration) do |channel|
#   SampleIntegration.channel_settings(channel)
# end

# Integrations.register(:configuration_form, :sample_integration) do |channel|
#   SampleIntegration.channel_settings_form(channel)
# end

# Integrations.subscribe([:configuration_data_updated, :sample_integration]) do |channel, configuration_params|
#   SampleIntegration.update_channel_settings(channel, configuration_params)
# end