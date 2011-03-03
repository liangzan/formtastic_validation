require 'rubygems'
require 'active_support'

module FormtasticValidation

  NAMESPACE = 'validation'
  @@valid_message = "Thank you!"
  mattr_accessor :valid_message

  def self.included(base)
    base.class_eval {
      alias_method_chain :input, :validation
    }
  end

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
      tags << { :validation => validation.macro }.merge(validation.options.merge(validation_valid_message_tag))
    end
    stack_tags(tags, input_html)
  end

  def validation_valid_message_tag
    { :valid_message => @@valid_message }
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
    opts_hash = otags_array.inject { |memo, hash| memo.merge(hash) }
    namespaced_hash = add_namespace(opts_hash)
    serialise_options(namespaced_hash)
  end

  def add_namespace(opts_hash)
    namespaced_hash = Hash.new
    opts_hash.each do |key, value|
      namespaced_key = (NAMESPACE + '_' + key.to_s).to_sym
      namespaced_hash[namespaced_key] = value
    end
    namespaced_hash
  end

  def serialise_options(opts_hash)
    serialised_hash = Hash.new
    opts_hash.each do |key, value|
      serialised_value = value.class.eql?(String) ? value : value.to_json
      serialised_hash[key] = serialised_value
    end
    serialised_hash
  end

end
