module BacklogKit
  class Resource
    def initialize(raw_data = {})
      @attributes = {}

      raw_data.each do |key, value|
        @attributes[key.to_sym] = process_value(value)
      end

      eigenclass = class << self; self; end
      eigenclass.send(:define_accessors, raw_data.keys)
    end

    class << self
      def define_accessors(attributes)
        attributes.each do |attribute|
          define_reader(attribute)
          define_writer(attribute)
          define_boolean_method(attribute)
        end
      end

      def define_reader(attribute)
        class_eval do
          define_method(attribute) do
            @attributes[attribute.to_sym]
          end

          alias_method(attribute.underscore, attribute)
        end
      end

      def define_writer(attribute)
        method_name = "#{attribute}="
        alias_method_name = "#{attribute.underscore}="

        class_eval do
          define_method(method_name) do |value|
            @attributes[attribute.to_sym] = value
          end

          alias_method(alias_method_name, method_name)
        end
      end

      def define_boolean_method(attribute)
        method_name = "#{attribute}?"
        alias_method_name = "#{attribute.underscore}?"

        class_eval do
          define_method(method_name) do
            !!@attributes[attribute.to_sym]
          end

          alias_method(alias_method_name, method_name)
        end
      end
    end

    private_class_method(
      :define_accessors,
      :define_reader,
      :define_writer,
      :define_boolean_method
    )

    private

    def process_value(value)
      case value
      when Hash  then self.class.new(value)
      when Array then value.map { |v| process_value(v) }
      else value
      end
    end
  end
end
