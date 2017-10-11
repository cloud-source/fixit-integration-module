require 'test_helper'

module SampleIntegration
  class ServiceTest < ActiveSupport::TestCase
    test "Fields" do
      service = SampleIntegration::Service.new
      assert service.respond_to? :url
      assert service.respond_to? :auth
    end

    test "Validates auth" do
      service = SampleIntegration::Service.new  url: "http://some.where" 
      assert ! service.valid?
      service.auth = "1123123"
      assert service.valid?
    end

    test "Validates url" do
      service = SampleIntegration::Service.new  auth: "123123" 
      assert ! service.valid?
      service.url = "http://some.where"
      assert service.valid?
    end

  end
end
