$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'formtastic_validation'

require 'rubygems'
gem 'activesupport', '2.3.8'
gem 'actionpack', '2.3.8'
require 'active_support'
require 'active_record'
require 'action_pack'
require 'action_view'
require 'action_controller'

gem 'rspec', '>= 1.3.0'
gem 'rspec-rails', '>= 1.3.2'
gem 'nokogiri', '>= 1.4.2'
gem 'rspec_tag_matchers', '>= 1.0.0'
gem 'validation_reflection', '>=0.3.8'
gem 'formtastic', '>=1.0.0'
require 'rspec_tag_matchers'
require 'validation_reflection'
require 'nokogiri'
require 'rspec_tag_matchers'
require 'formtastic'

Spec::Runner.configure do |config|
  config.include(RspecTagMatchers)
end

module FormtasticValidationSpecHelper
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::ActiveRecordHelper
  include ActionView::Helpers::RecordIdentificationHelper
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::AssetTagHelper
  include ActiveSupport
  include ActionController::PolymorphicRoutes

  include Formtastic::SemanticFormHelper
  Formtastic::SemanticFormBuilder.class_eval { include FormtasticValidation }

  class ::User ; end

  def setup_mocks
    def user_path(o); "/users/1"; end
    def users_path; "/users"; end
    def new_user_path; "/users/new"; end

    @bob = User.new
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
