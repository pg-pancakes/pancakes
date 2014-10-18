module Pancakes
  class ApplicationController < ActionController::Base
    private

    def connection
      Pancakes.connect(database: params[:database_id] || params[:id])
    end
  end
end
