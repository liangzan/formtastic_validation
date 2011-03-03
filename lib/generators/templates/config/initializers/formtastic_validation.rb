if Object.const_defined? "Formtastic"
  Formtastic::SemanticFormBuilder.send(:include, FormtasticValidation)

  # Set the default valid message. Default is Thank you!.
  # FormtasticValidation.valid_message = "its correct!"
end
