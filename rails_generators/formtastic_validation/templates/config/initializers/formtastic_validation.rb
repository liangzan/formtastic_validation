if Object.const_defined? "Formtastic"
  Formtastic::SemanticFormBuilder.send(:include, FormtasticValidation)
end
