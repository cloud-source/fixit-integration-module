require "sample_integration/engine"

module SampleIntegration
  # configurations: accessible via initializer of the main app
  mattr_accessor :integrated_report_is_to_be_shown
  @@integrated_report_is_to_be_shown = false

  def self.integrated_report_data(report)
    # returning integrated data to be shown with a thundermaps report
    if integrated_report_is_to_be_shown && (@@reports || {}).fetch(report.id, false)
      @@reports[report.id]
    end
  end

  def self.integrated_report_form(report)
    # returning integrated form fields definition.
    # you can use simple_form as reference for options available
    integrated_report = SampleIntegration::Report.where(report_id: report.id).first_or_initialize
    [
      {
        name: "sample_field_1",
        label: "Samplefield1",
        collection: [
          ['optionLabe1', 1],
          ['optionLabel2', 2],
        ],
        selected: 2,
      },
      {
        name: "sample_field_2",
        label: "SampleField2",
        placeholder: "type it here",
        html_input: {
          value: "preexising value",
        }
      },
    ]
  end

  def self.create_integrated_report(report, integrated_params)
    @@reports ||= {}
    @@reports[report.id] = integrated_params
  end

  def self.notify_report_creation(report)
    Rails.logger.info "Report created: #{report.id}"
  end

  def self.channel_settings(channel)
    # returning settings for account
    (@@settings || {})[account.id]
  end

  def self.channel_settings_form(channel)
    # returning fields to appear in integration configuration page
    # like integration credentials
    [
      {
        name: "username",
      },
      {
        name: "password",
      },
      {
        name: "enabled",
        as: :boolean,
      },
    ]
  end

  def self.update_channel_settings(channel, settings)
    # updating settings for channel
    @@settings ||= {}
    @@settings[account.id] ||= settings
  end
end
