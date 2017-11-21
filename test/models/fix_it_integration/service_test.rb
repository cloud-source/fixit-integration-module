require 'test_helper'

module FixItIntegration
  class ServiceTest < ActiveSupport::TestCase
    test "Fields" do
      service = FixItIntegration::Service.new
      assert service.respond_to? :url
      assert service.respond_to? :auth
    end

    test "Validates auth" do
      service = FixItIntegration::Service.new  url: "http://some.where" 
      assert ! service.valid?
      service.auth = "1123123"
      assert service.valid?
    end

    test "Validates url" do
      service = FixItIntegration::Service.new  auth: "123123" 
      assert ! service.valid?
      service.url = "http://some.where"
      assert service.valid?
    end

  end
end
