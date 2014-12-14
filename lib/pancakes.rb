require 'active_support/core_ext/module/attribute_accessors'
require 'net/ssh/gateway'
require 'pancakes/engine'
require 'pancakes/connection'
require 'pancakes/database'
require 'pancakes/record'
require 'pancakes/errors'

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
  mattr_accessor :gateway
  mattr_accessor :gateway_port
  mattr_accessor :environments
  mattr_accessor :connections
  @@connections = {}

  ###############
  ### METHODS ###
  ###############

  def self.connect(options = {})
    environment = (options[:database] || Rails.env).to_s
    @@connections[environment] ||= begin
      database_config = configurations[environment.to_s].merge(options)
      Pancakes::Connection.new(connection_hash(database_config))
    end
  end

  def self.configurations
    @@configurations ||= begin
      database_yml = (File.exist?(database_yml_path) && YAML.load_file(database_yml_path)) || {}
      pancakes_yml = (File.exist?(pancakes_yml_path) && YAML.load_file(pancakes_yml_path)) || {}
      merged_yml = database_yml.merge(pancakes_yml)
      merged_yml.slice(*Pancakes.environments)
    end
  end

  def self.connection_hash(database_config)
    {
      host:     database_config['host'],
      hostaddr: database_config['hostaddr'],
      port:     database_config['port'],
      dbname:   database_config['database'],
      user:     database_config['username'],
      password: database_config['password'],
      # connection_timeout: database_config['timeout'],
      # options: database_config['options'],
      # tty: database_config['tty'],
      # sslmode: database_config['sslmode'],
      # gsslib: database_config['gsslib'],
      # service: database_config['service']
    }
  end
end
