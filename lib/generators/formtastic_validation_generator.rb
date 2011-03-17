require 'rails/generators'

class FormtasticValidationGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  def install_formtastic_validations
      copy_file 'public/javascripts/formtastic_validation-0.1.4.min.js', 'public/javascripts/formtastic_validation-0.1.4.min.js'
      copy_file 'public/javascripts/livevalidation-1.3.min.js', 'public/javascripts/livevalidation-1.3.min.js'
      copy_file 'config/initializers/formtastic_validation.rb', 'config/initializers/formtastic_validation.rb'
  end
end
