require 'rails_helper'

describe Pancakes do
  before(:each) do
    Pancakes.setup do |pancake|
      pancake.connections = {}
      pancake.ssh_credentials = {}
      pancake.database_yml_path = Rails.root.join('config', 'database.yml')
      pancake.pancakes_yml_path = Rails.root.join('config', 'pancakes.yml')
      pancake.environments = begin
        Dir[Rails.root.join('config', 'environments', '*.rb')].map { |filename| File.basename(filename, '.rb') }
      end
    end
  end

  describe '#setup' do
    it 'saves a given configuration block' do
      ssh_credentials   = { username: 'test_user', password: '12345678' }
      database_yml_path = 'test/path/to/database.yml'
      pancakes_yml_path = 'test/path/to/pancakes.yml'
      environments      = [:test_1, :test_2, :test_3]
      connections       = { test_1: nil }

      Pancakes.setup do |pancake|
        pancake.ssh_credentials = ssh_credentials
        pancake.database_yml_path = database_yml_path
        pancake.pancakes_yml_path = pancakes_yml_path
        pancake.environments = environments
        pancake.connections = connections
      end

      expect(Pancakes.ssh_credentials).to eql ssh_credentials
      expect(Pancakes.database_yml_path).to eql database_yml_path
      expect(Pancakes.pancakes_yml_path).to eql pancakes_yml_path
      expect(Pancakes.environments).to eql environments
      expect(Pancakes.connections).to eql connections
    end
  end

  describe '#connect' do
    it 'connects to the current environment database by defualt' do
      # TODO: Currently we can't test this
    end

    it 'connects to a passed database' do
      # TODO: Currently we can't test this
    end
  end

  describe '#configurations' do
    it 'returns all available configurations' do
      # Do these configurations exist
      expect(Pancakes.configurations['test']).not_to be_nil
      expect(Pancakes.configurations['production']).not_to be_nil
      expect(Pancakes.configurations['development']).not_to be_nil
      # Do they have the correct values
      expect(Pancakes.configurations['test']['database']).to eql 'pancakes_test'
      expect(Pancakes.configurations['production']['database']).to eql 'pancakes_production'
      expect(Pancakes.configurations['development']['database']).to eql 'pancakes_development'
    end
  end
end
