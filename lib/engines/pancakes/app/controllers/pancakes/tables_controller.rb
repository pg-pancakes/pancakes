module Pancakes
  class TablesController < Pancakes::ApplicationController
    def show
      @tables  = database.tables
      @table   = @tables.find { |table| table.name == params[:id] }
      @records = @table.records
      @columns = @table.columns
    end

    private

    def database
      @database ||= Pancakes::Database.new(params[:database_id])
    end
    helper_method :database
  end
end
