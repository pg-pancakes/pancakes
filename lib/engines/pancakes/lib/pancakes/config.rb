module Pancakes

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

end