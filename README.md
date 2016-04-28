# SampleIntegration

## Description
This project is to be uses as reference when building new ThunderMaps
Integrations.

## Composition
Every ThunderMaps Integration is supposed to be a Rails Engine, but depending on
how simple is the integration any well structured gem may suffice.

## Initialization
The integration code may be provided with a rails initializer script to set it
up accordingly with every environment where it will run.

This initializer script should call the code which will connect the integration
via subscribing to published events and/or via registering callbacks to provide
data.

## Integration points
The application provide currently the following list of integration points but
that list can be extended on request if considered reasonable by ThunderMaps
Team.
Is worth saying that all of these integration points are optional so you can
implement only what is required for each case. But obviously, if you are providing
a `*_form` callback you will want to subscribe to one of the respective events
avalilable to make use of the data provided on such form fields.

### Channel Integrations
A report object is provided with all available information to every integration point in the list below.
* `:report_form_created_sync`: Event triggered on creation of a report. The date provided in the integrated form will be available under `report.integrated_forms[integration_name]` hash.
* `:report_form_created_async`: Event triggered asynchronously after a report creation.
* `:report_form`: Callback used to build integrated form fields to be presented with report form.
* `:report_data`: Callback used to retrieve data from integration to be displayed with a report.

### Configuration Integrations
A channel object is provided with all available information to every integration point in the list below.
* `:configuration_form`: Callback used to build configuration form to be presented to the user when he is configuring details for the integration.
* `:configuration_data`: Callback used to retrieve configuration for current integration.
* `:configuration_data_updated`: Event triggered when user updates its settings on integration configuration. Besides the channel object, a `updated_settings` hash is provided with this event to be stored and/or used as required.

## Initializer example:
```
# enabling presentation of integrated data
SampleIntegration.integrated_report_is_to_be_shown = true

Integrations.register(:report_data, "Sample Report Data") do |report|
  SampleIntegration.integrated_report_data(report)
end

Integrations.register(:report_form, :sample_integration) do |report|
  SampleIntegration.integrated_report_form(report)
end

Integrations.subscribe(:report_created_sync) do |report|
  SampleIntegration.create_integrated_report(report, report.integrated_forms[:sample_integration])
end

Integrations.subscribe(:report_created_async) do |report|
  SampleIntegration.notify_report_creation(report)
end

Integrations.register(:configuration_data, :sample_integration) do |channel|
  SampleIntegration.channel_settings(channel)
end

Integrations.register(:configuration_form, :sample_integration) do |channel|
  SampleIntegration.channel_settings_form(channel)
end

Integrations.register(:configuration_form, :sample_integration) do |channel|
  SampleIntegration.channel_settings_form(channel)
end

Integrations.subscribe(:configuration_data_updated) do |channel, configuration_params|
  SampleIntegration.update_channel_settings(channel, configuration_params)
end
```
## license
Copyright 2016 Cloudsource Limited.
