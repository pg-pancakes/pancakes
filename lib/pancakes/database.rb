module Pancakes
  class Database
    include ActiveModel::Conversion

    attr_reader :name, :connection

    def initialize(name)
      @name = name
      @connection = Pancakes.connect(database: name)
    end

    def tables
      table_names = self.connection.tables
      table_names.delete("schema_migrations")
      table_names.map { |table_name| Pancakes::Table.new(self, table_name) }
    end

    def exec_query(sql_query)
      self.connection.exec(sql_query)
    end
  end
end
