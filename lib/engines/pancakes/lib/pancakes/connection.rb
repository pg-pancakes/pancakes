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
      names = results.map { |result| result["table_name"] }
      names.map { |name| Pancakes::Table.new(name) }
    end
  end
end
