module Pancakes
  class DatabasesController < Pancakes::ApplicationController
    def show
      @tables = database.tables
    end

    def index
      redirect_to database_path(Rails.env)
    end

    private

    def database
      @database ||= Pancakes::Database.new(params[:id])
    end
    helper_method :database
  end
end
