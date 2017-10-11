require 'test_helper'

module SampleIntegration
  class SettingTest < ActiveSupport::TestCase

    attr_accessor :channel_id


    def subject
      self.channel_id ||= 0
      self.channel_id += 1

      SampleIntegration::Setting.new(channel_id: channel_id, geom: "POLYGON((174.55078125 -31.26446555575282,-177.890625 -39.6945074985609,169.62890625 -50.22260931189022,162.59765625 -45.51019654498557,174.55078125 -31.26446555575282))", 
        fault_description: "test", branded_app_id: 1, service: Service.first)
    end

    test "Fields" do
      assert subject.respond_to? :channel_id
      assert subject.respond_to? :geom
      assert subject.respond_to? :fault_description
      assert subject.respond_to? :branded_app_id
      assert subject.respond_to? :service
    end

    test "Validates channel" do
      setting = subject 
      setting.channel_id = nil
      assert ! setting.valid?

      #negative numbers disallowed
      setting.channel_id = -1
      assert ! setting.valid?

      #uniqueness
      setting2 = subject
      setting2.save!
      setting.channel_id = setting2.channel_id
      assert ! setting.valid?      

      setting2.delete
    end

    test "Validates geom" do
      setting = subject 
      setting.geom = nil
      assert ! setting.valid?
    end

    test "Validates fault_description" do
      setting = subject 
      setting.fault_description = nil
      assert ! setting.valid?
    end

    test "Validates branded app" do
      setting = subject 
      setting.branded_app_id = nil
      assert ! setting.valid?
      setting.branded_app_id = -1
      assert ! setting.valid?
    end

    test "Validates service" do
      setting = subject 
      setting.service = nil
      assert ! setting.valid?
    end
  end
end
