module Pancakes
  class Database
    include ActiveModel::Conversion

    attr_reader :name

    def initialize(name)
      @name = name
      Pancakes.connect(database: name)
    end

    def tables
      results = Pancakes.connection.exec("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
      names = results.map { |result| result["table_name"] }
      names.map { |name| Pancakes::Table.new(name) }
    end
  end
end
