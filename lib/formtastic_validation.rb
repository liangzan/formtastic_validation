module FormtasticValidation

  def self.included(base)
    base.class_eval do
      include ValidationMethods
      alias_method_chain :input, :validation
    end
  end

  module ValidationMethods
    def input_with_validation(method, options = {})
      if has_validations?(method)
        options[:input_html] = validation_tags(method, options[:input_html])
      end
      input_without_validation(method, options)
    end

    def has_validations?(attribute)
      if @object && @object.class.respond_to?(:reflect_on_validations_for)
        @object.class.reflect_on_validations_for(attribute_sym(attribute)).present?
      else
        false
      end
    end

    def attribute_sym(attribute)
      attribute.to_s.sub(/_id$/, '').to_sym
    end

    def validation_tags(attribute, input_html)
      tags = []
      @object.class.reflect_on_validations_for(attribute).each do |validation|
        tags << { :validation => validation.macro }.merge(validation.options)
      end
      stack_tags(tags, input_html)
    end

    def stack_tags(tags, input_html)
      vtags = validates_tags(tags.dup)
      otags = options_tags(tags.dup)
      if input_html
        input_html[:validation] = vtags
        input_html.merge(otags)
      else
        { :validation => vtags }.merge(otags)
      end
    end

    def validates_tags(tags)
      validates_tags = tags.map { |tag| tag[:validation] }
      validates_tags.join(' ')
    end

    def options_tags(tags)
      otags_array = tags.map do |tag|
        tag.delete_if { |key, value| key.eql?(:validation) }
      end
      otags_array.inject { |memo, hash| memo.merge(hash) }
    end
  end
end


if Object.const_defined? "Formtastic"
  Formtastic::SemanticFormBuilder.class_eval { include FormtasticValidation }
end

