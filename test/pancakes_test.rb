require 'test_helper'

class PancakesTest < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, Pancakes
  end

  test '.connect' do
    connection = Pancakes.connect
    # TODO: Write an actuall test
    #       Currently not possible as there is no
    #       Pancakes wrapper for a connections
    assert connection
  end

  test '.setup' do
    ssh_credentials = { username: 'test_user', password: '12345678' }
    database_yml_path = 'test/path/to/database.yml'
    pancakes_yml_path = 'test/path/to/pancakes.yml'
    environments = [:test_1, :test_2, :test_3]
    connections = { test_1: nil }

    Pancakes.setup do |pancake|
      pancake.ssh_credentials = ssh_credentials
      pancake.database_yml_path = database_yml_path
      pancake.pancakes_yml_path = pancakes_yml_path
      pancake.environments = environments
      pancake.connections = connections
    end

    assert_equal ssh_credentials, Pancakes.ssh_credentials
    assert_equal database_yml_path, Pancakes.database_yml_path
    assert_equal pancakes_yml_path, Pancakes.pancakes_yml_path
    assert_equal environments, Pancakes.environments
    assert_equal connections, Pancakes.connections
  end

  test '.configurations' do
    configurations = Pancakes.configurations
    assert configurations['test']
    assert configurations['production']
    assert configurations['development']
    assert_equal 'pancakes_test', configurations['test']['database']
    assert_equal 'pancakes_production', configurations['production']['database']
    assert_equal 'pancakes_development', configurations['development']['database']
  end
end
