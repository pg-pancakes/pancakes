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

    def exec_query(sql_query)
      Pancakes.connection.exec(sql_query)
    end
  end
end
