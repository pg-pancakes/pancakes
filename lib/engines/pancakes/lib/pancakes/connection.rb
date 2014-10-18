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
  end
end
