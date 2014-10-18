module Pancakes
  class DatabasesController < ApplicationController
    def show
      # connect to pg/database/:database
    end

    def index
      redirect_to database_path(Rails.env)
    end
  end
end
