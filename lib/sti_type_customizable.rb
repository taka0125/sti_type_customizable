# frozen_string_literal: true
require "sti_type_customizable/version"
require "sti_type_customizable/definition"

require "active_support"
require "active_support/core_ext"

module StiTypeCustomizable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :_sti_definition, instance_accessor: false
  end

  class_methods do
    def sti_definition(definition)
      self._sti_definition = definition
    end

    def find_sti_class(type)
      self._sti_definition.resolve_class(type) || self
    end

    def sti_name
      self._sti_definition.resolve_type_value(self)
    end
  end
end
