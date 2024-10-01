# lib/aws-sdk-rails-eagerloader/railtie.rb

require 'rails/railtie'

module AwsSdkRailsEagerloader
  class Railtie < Rails::Railtie
    initializer 'aws-sdk-rails.sdk_eager_load' do
      config.before_eager_load do
        config.eager_load_namespaces << Aws
      end
      Aws.define_singleton_method(:eager_load!) do
        Aws.constants.each do |c|
          m = Aws.const_get(c)
          next unless m.is_a?(Module)
          m.constants.each do |constant|
            m.const_get(constant)
          end
        end
      end
    end
  end
end
