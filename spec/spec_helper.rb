$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'active_support'
require 'action_pack'
require 'action_view'
require 'action_controller'

require 'formtastic'
require 'formtastic_validation'

require 'rspec_tag_matchers'
require 'action_controller/railtie'
require 'active_resource/railtie'
require 'active_model'
require 'validation_reflection'
require 'nokogiri'

module FormtasticTest
  class Application < Rails::Application
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    config.active_support.deprecation = :stderr
  end
end
FormtasticTest::Application.initialize!

require 'rspec/rails'

RSpec.configure do |config|
  config.include(RspecTagMatchers)
  config.mock_with :rspec
end

module ActionView
  class OutputBuffer < Formtastic::Util.rails_safe_buffer_class
  end
end

module FormtasticValidationSpecHelper
  include ActionPack
  include ActionView::Context if defined?(ActionView::Context)
  include ActionController::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::ActiveRecordHelper if defined?(ActionView::Helpers::ActiveRecordHelper)
  include ActionView::Helpers::ActiveModelHelper if defined?(ActionView::Helpers::ActiveModelHelper)
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::AssetTagHelper
  include ActiveSupport
  include ActionController::PolymorphicRoutes if defined?(ActionController::PolymorphicRoutes)

  include Formtastic::SemanticFormHelper
  Formtastic::SemanticFormBuilder.class_eval { include FormtasticValidation }

  class ::User
    extend ActiveModel::Naming if defined?(ActiveModel::Naming)
    include ActiveModel::Conversion if defined?(ActiveModel::Conversion)

    def id
    end

    def persisted?
    end
  end

  def setup_mocks
    def user_path(o); "/users/1"; end
    def users_path; "/users"; end
    def new_user_path; "/users/new"; end

    @bob = ::User.new
    @bob.stub!(:class).and_return(::User)
    @bob.stub!(:name).and_return('Bob')
    @bob.stub!(:email).and_return('bob@mail.com')
    @bob.stub!(:mobile).and_return('123456')
  end

  def self.included(base)
    base.class_eval do
      attr_accessor :output_buffer

      def protect_against_forgery?
        false
      end
    end
  end

end
