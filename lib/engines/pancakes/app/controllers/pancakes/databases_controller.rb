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
        raise Pancakes::Errors::EmptyQueryString.new if params[:sql_command] =~ /drop|alter/i
        raise Pancakes::Errors::EmptyQueryString.new if params[:sql_command].blank?
        @result = database.exec_query(params[:sql_command])
      rescue PG::Error, Pancakes::Errors::EmptyQueryString => e
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
