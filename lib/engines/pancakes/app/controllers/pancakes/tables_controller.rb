module Pancakes
  class TablesController < ApplicationController
    def show
      @tables  = connection.tables
      @table   = @tables.find { |table| table.name == params[:id] }
      @records = @table.records
      @columns = @table.columns
    end
  end
end
