require "active_model/conversion"

module Pancakes
  class Table
    include ActiveModel::Conversion

    attr_reader :database, :connection, :name

    def initialize(database,name)
      @database = database
      @connection = database.connection
      @name = name
    end

    def records
      self.connection.records(name)
    end

    def sorted_records(params)
      self.connection.sorted_records(name, params)
    end

    def columns
      self.connection.columns(name)
    end

    def count
      result = self.connection.count(name)
      result.first['count'].to_i
    end

    def primary_keys
      self.connection.primary_keys(name)
    end

    def insert(attributes)
      self.connection.insert(name, attributes)
    end

    def update(id, attributes)
      self.connection.update(name, id, attributes)
    end

    def schema
      self.connection.schema_query(name)
    end
  end
end
