require "active_model/conversion"

module Pancakes
  class Table
    include ActiveModel::Conversion

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def records
      Pancakes.connection.records(name)
    end

    def columns
      Pancakes.connection.columns(name)
    end

    def primary_keys
      Pancakes.connection.primary_keys(name)
    end

    def insert(attributes)
      Pancakes.connection.insert(name, attributes)
    end

    def update(id, attributes)
      Pancakes.connection.update(name, id, attributes)
    end

    def schema
      Pancakes.connection.schema_query(name)
    end
  end
end
