require_dependency 'pancakes/application_controller'

module Pancakes
  class RecordsController < ApplicationController
    def create
      @record = table.insert(params[:attributes]).to_a.first
    rescue PG::Error => e
      @error = e
      render status: 500
    end

    def update
      table.update(params[:id], params[:attributes])
    rescue PG::Error => e
      @error = e
      render status: 500
    end

    def destroy
      table.delete(params[:id])
    rescue PG::Error => e
      @error = e
      render status: 500
    end

    private

    def database
      @database ||= Pancakes::Database.new(params[:database_id])
    end

    def table
      @table ||= Pancakes::Table.new(database, params[:table_id])
    end
  end
end
