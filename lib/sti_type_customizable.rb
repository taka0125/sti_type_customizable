# frozen_string_literal: true
require "sti_type_customizable/version"
require "active_support/concern"

module StiTypeCustomizable
  extend ActiveSupport::Concern

  included do
    class_attribute :sti_type_value
  end

  class_methods do
    def sti_child_classes(classes)
      @sti_entities ||= begin
        {}.tap do |entities|
          classes.each do |klass|
            raise NotImplementedError unless klass.include? StiTypeCustomizable

            entities[klass.sti_type_value] = klass
          end
        end
      end
    end

    def find_sti_class(type)
      @sti_entities[type] || self
    end

    def sti_name
      @sti_entities.invert[self] || self::sti_type_value
    end
  end
end
