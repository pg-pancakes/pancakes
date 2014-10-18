require "active_model/conversion"

module Pancakes
  class Table
    include ActiveModel::Conversion

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def records
      Pancakes.connection.exec "SELECT * FROM #{name}"
    end

    def columns
      Pancakes.connection.exec "SELECT column_name FROM information_schema.columns WHERE table_name = '#{name}'"
    end
  end
end
