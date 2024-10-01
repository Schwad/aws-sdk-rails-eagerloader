# test/aws_sdk_rails_eagerloader/railtie_test.rb

require 'test_helper'
require 'aws-sdk-rails-eagerloader'

module AwsSdkRailsEagerloader
  class RailtieTest < Minitest::Test
    def setup
      @rails_app = Class.new(::Rails::Application)
      ::Rails.application = @rails_app
      ::Rails.stub :env, ActiveSupport::StringInquirer.new("test") do
        ::Rails.application.config.eager_load = true
        Railtie.initializers.each do |initializer|
          initializer.run(@rails_app)
        end
      end
    end

    def test_sets_up_eager_loading_for_sdk_services
      assert_includes Aws.methods, :eager_load!
      assert_includes ::Rails.application.config.eager_load_namespaces, Aws
    end

    def test_aws_eager_load_method
      Aws.stub :constants, [:S3, :SQS] do
        Aws.stub :const_get, Module.new do
          Aws.eager_load!
        end
      end
    end

    def test_aws_eager_load_skips_non_module_constants
      Aws.stub :constants, [:VERSION, :S3] do
        Aws.stub :const_get, ->(const) { const == :VERSION ? "1.0.0" : Module.new } do
          assert_silent { Aws.eager_load! }
        end
      end
    end

    def test_adds_aws_to_eager_load_namespaces
      assert_includes ::Rails.application.config.eager_load_namespaces, Aws
    end

    def test_calls_aws_eager_load_when_triggered
      Aws.stub :eager_load!, -> { @eager_load_called = true } do
        ::Rails.application.config.eager_load_namespaces.each(&:eager_load!)
        assert @eager_load_called, "Aws.eager_load! should have been called"
      end
    end
  end
end
