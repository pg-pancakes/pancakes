module Pancakes
  class ExtensionsController < Pancakes::ApplicationController

    def create
      database.connection.create_extension(params[:name], if_not_exists: true)
      render json: { installed: true, version: database.connection.extension_installed_version(params[:name]) }
    rescue PG::UndefinedFile
      render json: { installed: false }
    end

    def destroy
      r = database.connection.drop_extension(params[:id])
      render json: { installed: true }
    rescue PG::UndefinedObject
      render json: { uninstalled: false }
    end

    private

    def database
      @database ||= Pancakes::Database.new(params[:database_id])
    end
    helper_method :database
  end
end
