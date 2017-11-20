require "sample_integration/engine"

module SampleIntegration
  # configurations: accessible via initializer in the main app
  mattr_accessor :integrated_report_is_to_be_shown
  @@integrated_report_is_to_be_shown = false

  mattr_accessor :reports
  @@reports = {}

  mattr_accessor :settings
  @@settings = {}

  def self.integrated_report_data(report)
    # returning integrated data to be shown with a thundermaps report
    if integrated_report_is_to_be_shown && reports.fetch(report.id, false)
      reports[report.id]
    end
  end

  def self.integrated_report_form(report)
    {}
  end

  def self.create_integrated_report(report, integrated_params)
    reports[report.id] = integrated_params
  end

  def self.notify_report_creation(report)
    Rails.logger.info "Report created: #{report.id}"

    #Check report belongs to relevant channel, and is inside a service area
    Setting.where("ST_WITHIN(?, geom) AND channel_id = ?", report.location, report.account_id).each do |s|
      s.send_report(report)
    end


  end

  def self.channel_settings(channel)
    # returning settings for channel
    settings[channel.id] || {}
  end

  def self.channel_settings_form(channel)
    # # returning fields to appear in integration configuration page
    # # like integration credentials
    # [
    #   {
    #     name: "account",
    #   },
    #   {
    #     name: "credentials",
    #     as: :password,
    #   },
    #   {
    #     name: "enabled",
    #     as: :boolean,
    #   },
    # ]
  end

  def self.update_channel_settings(channel, channel_settings_params)
    # updating settings for channel
    settings[channel.id] = channel_settings_params
  end
end
