require "rails"
require "net/ssh/gateway"
require "pancakes/engine"
require "pancakes/database/connection"

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

  mattr_accessor :config_file_path
  @@config_file_path = "/config/pancakes.yml"

  mattr_accessor :connection
  @@connection = nil

  mattr_accessor :gateway
  @@gateway = nil

  mattr_accessor :environments
  @@environments = Dir.glob("./config/environments/*.rb").map { |filename| File.basename(filename, ".rb") }

  ###############
  ### METHODS ###
  ###############

  def self.connect options={}
    # Read configuration
    databases = read_configuration || {}
    database = databases[options[:database].to_s || Rails.env]
    database = database.merge(options)
    # Tunnel SSH
    #Pancakes.gateway = Net::SSH::Gateway.new("host","user",{:verbose => :debug})
    # Connect to DB
    Pancakes.connection = PG::Connection.new(
      host: database["host"],
      hostaddr: database["hostaddr"],
      port: database["port"],
      dbname: database["database"],
      user: database["username"],
      password: database["password"],
      #connection_timeout: database["timeout"],
      #options: database["options"],
      #tty: database["tty"],
      #sslmode: database["sslmode"],
      #gsslib: database["gsslib"],
      #service: database["service"],
    )
  end

  def self.read_configuration
    database_yaml_path = "./config/database.yml"
    enviroments_path = "./config/environments"
    databases = (File.exists?(database_yaml_path) && YAML.load_file(database_yaml_path)) || {}
    configuration = (File.exists?(Pancakes.config_file_path) && YAML.load_file(Pancakes.config_file_path)) || {}
    enviroments = Dir.glob("#{enviroments_path}/*.rb").map { |filename| File.basename(filename, ".rb") }
    databases = databases.merge configuration
    databases.keys.each do |database|
      databases.delete(database) unless enviroments.include? database
    end
    databases
  end



end
