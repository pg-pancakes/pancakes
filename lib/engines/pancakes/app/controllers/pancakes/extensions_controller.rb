module Pancakes
  class ExtensionsController < Pancakes::ApplicationController

    def create
      database.connection.create_extension(params[:name], if_not_exists: true)
      @success = true
    rescue PG::UndefinedFile
      @success = false
    end

    def destroy
      database.connection.drop_extension(params[:id])
      @success = true
    rescue PG::UndefinedObject
      @success = false
    end

    private

    def database
      @database ||= Pancakes::Database.new(params[:database_id])
    end
    helper_method :database
  end
end
