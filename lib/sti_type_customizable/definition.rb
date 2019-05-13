# frozen_string_literal: true

module StiTypeCustomizable
  module Definition
    def initialize(default_type_value)
      @definitions = load_definitions
      @inverted_definitions = @definitions.invert
      @module_name = self.class.name.deconstantize
      @default_type_value = default_type_value
    end

    def resolve_class(type_value)
      key = @inverted_definitions.dig(type_value)
      return nil if key.blank?

      "#{@module_name}::#{key.to_s.classify}".safe_constantize
    end

    def resolve_type_value(klass)
      @definitions.dig(klass.name.demodulize.underscore.to_sym) || @default_type_value
    end

    private

    def load_definitions
      raise NotImplementedError
    end
  end
end
