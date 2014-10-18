require_dependency "pancakes/application_controller"

module Pancakes
  class RecordsController < ApplicationController
    def create
      attributes = table.insert(params[:record])
      @record = Pancakes::Record.new(attributes)
    rescue PG::Error => e
      render status: 500
    end

    def update
      attributes = table.update(params[:id], params[:attributes])
      @record = Pancakes::Record.new(attributes.to_a.first)
    rescue PG::Error => e
      render status: 500
    end

    def destroy
      table.delete(params[:id])
    end

    private

    def table
      @table ||= Pancakes::Table.new(params[:table_id])
    end
  end
end