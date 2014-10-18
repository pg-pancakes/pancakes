require "rails"
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

  mattr_accessor :environments
  @@environments = Dir.glob("./config/environments/*.rb").map { |filename| File.basename(filename, ".rb") }

  ###############
  ### METHODS ###
  ###############

  def read_configuration
  	
  end

end
