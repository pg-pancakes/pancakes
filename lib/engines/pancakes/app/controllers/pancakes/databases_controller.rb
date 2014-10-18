module Pancakes
  class DatabasesController < ApplicationController
    def show
      @tables = connection.tables
    end

    def index
      redirect_to database_path(Rails.env)
    end
  end
end
