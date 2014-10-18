module Pancakes
  class ServersController < ApplicationController
    def show
      $pg.connection = PG::Connection.new(
        host: "127.0.0.1",
        port: "5432",
        user: "postgres",
      )

      @databases = $pg.connection.exec("SELECT datname FROM pg_database")
        .map { |record| record["datname"] }
    end
  end
end
