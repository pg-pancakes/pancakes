require "active_model/conversion"

module Pancakes
  class Table
    include ActiveModel::Conversion

    HSTORE_DATA_TYPE = 'USER-DEFINED'

    attr_reader :database, :connection, :name

    def initialize(database,name)
      @database = database
      @connection = database.connection
      @name = name
    end

    def records
      @records ||= self.connection.records(name)
      parse_hstore(@records) if hstore_columns.any?
    end

    def sorted_records(params)
      @sorted_records ||= self.connection.sorted_records(name, params)
      parse_hstore(@sorted_records) if hstore_columns.any?
    end

    def columns
      @columns ||= self.connection.columns(name)
    end

    def count
      result = self.connection.count(name)
      result.first['count'].to_i
    end

    def primary_keys
      @primary_keys ||= self.connection.primary_keys(name)
    end

    def insert(attributes)
      self.connection.insert(name, attributes)
    end

    def update(id, attributes)
      self.connection.update(name, id, attributes)
    end

    def delete(id)
      self.connection.delete(name, id)
    end

    def schema
      @schema ||= self.connection.schema_query(name)
    end

    private

      def parse_hstore(records)
        parsed_records = records.map do |record|
          hstore_columns.each do |hstore_column|
            if record[hstore_column]
              record[hstore_column] = PgHstore.load(record[hstore_column]).to_json
            end
          end
          record
        end
      end

      def hstore_columns
        @hstore_columns ||= schema.map{|column| column['column_name'] if column['data_type'] == HSTORE_DATA_TYPE }.compact
      end
  end
end