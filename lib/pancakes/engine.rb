module Pancakes
  class Engine < ::Rails::Engine
    isolate_namespace Pancakes

    initializer 'pancakes.connection' do
      Pancakes.database_yml_path ||= Rails.root.join('config', 'database.yml')
      Pancakes.pancakes_yml_path ||= Rails.root.join('config', 'pancakes.yml')
      Pancakes.environments ||= begin
        Dir[Rails.root.join('config', 'environments', '*.rb')].map { |filename| File.basename(filename, '.rb') }
      end
    end

    # Testing framework initialization
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
