class FormtasticValidationGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.file 'public/javascripts/formtastic_validation-0.1.0.min.js', 'public/javascripts/formtastic_validation-0.1.0.min.js'
      m.file 'public/javascripts/livevalidation-1.3.min.js', 'public/javascripts/livevalidation-1.3.min.js'
      m.file 'config/initializers/formtastic_validation.rb', 'config/initializers/formtastic_validation.rb'
    end
  end

  protected

  def banner
    %\Usage: #{$0} formtastic_validation\
  end
end
