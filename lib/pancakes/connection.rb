require 'delegate'
require 'pg'
require 'pg_hstore'
require 'pancakes/table'

module Pancakes
  class Connection < SimpleDelegator
    def initialize(options)
      super PG::Connection.new(options)
    end

    def databases
      results = exec('SELECT datname FROM pg_database')
      names = results.map { |result| result['datname'] }
      names.reject { |table| table.name =~ /template\d+/ || table.name == 'postgres' }
    end

    def tables
      results = exec('SELECT table_name FROM information_schema.tables WHERE table_schema = \'public\'')
      results.map { |result| result['table_name'] }
    end

    def records(table_name)
      exec("SELECT * FROM #{table_name} ORDER BY id ASC")
    end

    def sorted_records(table_name, params)
      query = "SELECT * FROM #{table_name}"

      if params[:sort_attribute]
        query += " ORDER BY #{params[:sort_attribute]} #{params[:order]}"
      end

      if params[:page]
        offset = params[:per_page].to_i * (params[:page].to_i - 1)
        limit  = params[:per_page]
        query += " LIMIT #{limit} OFFSET #{offset}"
      end

      exec(query)
    end

    def columns(table_name)
      exec("SELECT column_name FROM information_schema.columns WHERE table_name = '#{table_name}'")
    end

    def count(table_name)
      exec("SELECT COUNT(*) FROM #{table_name}")
    end

    def primary_keys(table_name)
      exec('SELECT pg_attribute.attname, format_type(pg_attribute.atttypid, pg_attribute.atttypmod)'\
           'FROM pg_index, pg_class, pg_attribute '\
           "WHERE pg_class.oid = '#{table_name}'::regclass AND indrelid = pg_class.oid AND pg_attribute.attrelid = pg_class.oid AND pg_attribute.attnum = any(pg_index.indkey) AND indisprimary")
    end

    def schema_query(table_name)
      exec("select column_name, data_type, character_maximum_length, is_nullable from INFORMATION_SCHEMA.COLUMNS where table_name = '#{table_name}';")
    end

    def insert(table_name, attributes)
      exec("INSERT INTO #{table_name} (#{attributes.keys.join(', ')}) VALUES (#{attributes.values.map { |v| "'#{v}'" }.join(', ')}) RETURNING *")
    end

    def update(table_name, id, attributes)
      exec("UPDATE #{table_name} SET #{attributes.map { |k, v| "#{k} = '#{v}'" }.join(', ')} WHERE id = #{id} RETURNING *")
    end

    def delete(table_name, id)
      exec("DELETE FROM #{table_name} WHERE id = #{id}")
    end

    def all_extensions
      exec('SELECT * FROM pg_available_extensions')
    end

    def installed_extensions
      exec('SELECT extname, extversion FROM pg_extension')
    end

    def create_extension(extension_name, params = {})
      command = 'CREATE EXTENSION'
      command << ' IF NOT EXISTS' if params[:if_not_exists]
      command << " #{extension_name}"
      command << ' WITH'                         if params[:old_version]
      command << " SCHEMA #{params[:schema]}"    if params[:schema]
      command << " VERSION #{params[:version]}"  if params[:version]
      command << " FROM #{params[:old_version]}" if params[:old_version]
      exec(command)
    end

    def drop_extension(extension_name, params = {})
      command = 'DROP EXTENSION'
      command << 'IF EXISTS' if params[:if_exists]
      command << " #{extension_name}"
      if params[:cascade] && !params[:restrict]
        command << ' CASCADE'
      elsif !params[:cascade] && params[:restrict]
        command << ' RESTRICT'
      end
      exec(command)
    end

    def extension_installed_version(extension_name)
      exec("SELECT installed_version FROM pg_available_extensions WHERE name LIKE '#{extension_name}'").values.flatten.first
    end

  end
end
