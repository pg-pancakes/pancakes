module Pancakes
  class TablesController < Pancakes::ApplicationController
    def show
      @tables  = database.tables
      @table   = @tables.find { |table| table.name == params[:id] }

      @records = if sorting_and_pagination_params.any?
                   @table.sorted_records(sorting_and_pagination_params)
                 else
                   @table.records
                 end

      @columns = @table.columns
      @schema  = @table.schema
      @count   = @table.count
    end

    private

    def database
      @database ||= Pancakes::Database.new(params[:database_id])
    end
    helper_method :database

    def sorting_and_pagination_params
      @sorting_params ||= params.permit(:sort_attribute, :order, :per_page, :page)
    end

  end
end
