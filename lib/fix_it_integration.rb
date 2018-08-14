require "fix_it_integration/engine"

module FixItIntegration
  # configurations: accessible via initializer in the main app
  mattr_accessor :integrated_report_is_to_be_shown
  @@integrated_report_is_to_be_shown = false

  mattr_accessor :reports
  @@reports = {}

  mattr_accessor :settings
  @@settings = {}

  def self.notify_report_creation(report)
    Rails.logger.info "Report created: #{report.id}"

    #Check report belongs to relevant channel, and is inside a service area
    Setting.where("ST_WITHIN(?, geom) AND channel_id = ?", report.geom, report.account_id).each do |s|
      s.send_report(report)
    end
  end
end
