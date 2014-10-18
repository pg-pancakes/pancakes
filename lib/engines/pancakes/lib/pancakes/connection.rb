require "delegate"
require "pg"
require "pancakes/table"

module Pancakes
  class Connection < SimpleDelegator
    def initialize(options)
      super PG::Connection.new(options)
    end

    def databases
      results = exec("SELECT datname FROM pg_database")
      names = results.map { |result| result["datname"] }
      names.reject { |table| table.name =~ /template\d+/ || table.name == "postgres" }
    end

    def tables
      results = exec("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
      results.map { |result| result["table_name"] }
    end

    def records(table_name)
      exec("SELECT * FROM #{table_name}")
    end

    def columns(table_name)
      exec("SELECT column_name FROM information_schema.columns WHERE table_name = '#{table_name}'")
    end

    def schema_query(table_name)
      exec("select column_name, data_type, character_maximum_length, is_nullable from INFORMATION_SCHEMA.COLUMNS where table_name = '#{table_name}';")
    end

    def insert(table_name, attributes)
      exec("INSERT INTO #{table_name} (#{attributes.keys.join(", ")}) VALUES (#{attributes.values.join(", ")}) RETURNING *")
    end

    def update(table_name, id, attributes)
      exec("UPDATE #{table_name} SET #{attributes.map { |k, v| "#{k} = '#{v}'" }.join(", ")} WHERE id = #{id} RETURNING *")
    end

    def delete(table_name, id)
      exec("DELETE FROM #{table_name} WHERE id = #{id}")
    end
  end
end
