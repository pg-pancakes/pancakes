module Pancakes
  class DatabasesController < Pancakes::ApplicationController
    def show
      @tables = database.tables
    end

    def index
      redirect_to database_path(Rails.env)
    end

    def query
      begin
        @result = database.exec_query(params[:sql_command])
      rescue PG::Error => e
        @error = e
      end
    end

    private

    def database
      @database ||= Pancakes::Database.new(params[:id])
    end
    helper_method :database
  end
end
