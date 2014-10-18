module Pancakes
  class DatabasesController < ApplicationController
    def show
      connection = Pancakes.connect(database: params[:id])
      connection.exec("SELECT table_name FROM information_schema.tables WHERE table_schema='public'")
    end

    def index
      redirect_to database_path(Rails.env)
    end
  end
end
