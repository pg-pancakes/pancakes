require "active_support/core_ext/module/attribute_accessors"
require "net/ssh/gateway"
require "pancakes/engine"
require "pancakes/connection"
require "pancakes/database"

module Pancakes

  #####################
  ### CONFIGURATION ###
  #####################

  def self.setup
    yield self
  end

  mattr_accessor :standalone
  @@standalone = false

  mattr_accessor :ssh_credentials
  @@ssh_credentials = {}

  mattr_accessor :database_yml_path
  mattr_accessor :pancakes_yml_path
  mattr_accessor :connection
  mattr_accessor :gateway
  mattr_accessor :gateway_port
  mattr_accessor :environments

  ###############
  ### METHODS ###
  ###############

  def self.connect options={}
    # Read configuration
    environment = options[:database].to_s || Rails.env
    database_config = configurations[environment].merge(options)
    # Tunnel SSH
    #if Pancakes.
    #Pancakes.gateway = Net::SSH::Gateway.new("host","user",{:verbose => :debug})
    # Connect to DB

    connection_hash = {
      host:     database_config["host"],
      hostaddr: database_config["hostaddr"],
      port:     database_config["port"],
      dbname:   database_config["database"],
      user:     database_config["username"],
      password: database_config["password"],
      #connection_timeout: database_config["timeout"],
      #options: database_config["options"],
      #tty: database_config["tty"],
      #sslmode: database_config["sslmode"],
      #gsslib: database_config["gsslib"],
      #service: database_config["service"]
    }

    Pancakes.connection = Pancakes::Connection.new(connection_hash)
  end

  def self.configurations
    @configurations ||= begin
      database_yml = (File.exists?(database_yml_path) && YAML.load_file(database_yml_path)) || {}
      pancakes_yml = (File.exists?(pancakes_yml_path) && YAML.load_file(pancakes_yml_path)) || {}
      merged_yml = database_yml.merge(pancakes_yml)
      merged_yml.slice *Pancakes.environments
    end
  end

end
