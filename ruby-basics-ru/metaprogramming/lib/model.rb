# frozen_string_literal: true

# BEGIN
module Model
  TYPE_CONVERTERS = {
    integer: ->(value) { value.nil? ? nil : value.to_i },
    string: ->(value) { value.nil? ? nil : value.to_s },
    datetime: ->(value) { value.nil? ? nil : DateTime.parse(value) },
    boolean: ->(value) { value.nil? ? nil : value }
  }.freeze

  module ClassMethods
    def attribute(name, options = {})
      attrs_schema[name] = options || {}

      define_method(name) do
        convert_to_specified_type(name, instance_variable_get("@#{name}"))
      end

      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
      end
    end

    def attrs_schema
      @attrs_schema ||= {}
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def initialize(attrs = {})
    self.class.attrs_schema.each_key do |attr_name|
      instance_variable_set(
        "@#{attr_name}",
        attrs[attr_name] || try_to_find_default_value(attr_name)
      )
    end
  end

  def attributes
    self.class.attrs_schema.keys.each_with_object({}) do |attr_name, result|
      result[attr_name] = send(attr_name)
    end
  end

  private

  def try_to_find_default_value(attr_name)
    self.class.attrs_schema.dig(attr_name, :default)
  end

  def convert_to_specified_type(attr_name, value)
    type = self.class.attrs_schema.dig(attr_name, :type)
    type ? TYPE_CONVERTERS[type].call(value) : value
  end
end
# END
