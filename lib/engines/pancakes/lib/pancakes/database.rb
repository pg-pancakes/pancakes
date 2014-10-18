module Pancakes
  class Database
    include ActiveModel::Conversion

    attr_reader :name

    def initialize(name)
      @name = name
      Pancakes.connect(database: name)
    end

    def tables
      names = Pancakes.connection.tables
      names.map { |name| Pancakes::Table.new(name) }
    end
  end
end
