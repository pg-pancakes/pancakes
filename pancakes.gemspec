$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'pancakes/version'

# Authors
authors = {
  'Janko Marohnić'          => 'janko.marohnic@gmail.com',
  'Stanko Krtalić Rusendić' => 'stanko.krtalic@gmail.com',
  'Marko Ivanek'            => 'marko.ivanek@gmail.com',
  'Damir Svrtan'            => 'damir.svrtan@gmail.com'
}

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'pancakes'
  s.version     = Pancakes::VERSION
  s.authors     = authors.keys
  s.email       = authors.values
  s.homepage    = 'https://github.com/pg-pancakes/pancakes'
  s.summary     = 'In browser database managment tool for Postgres databases'
  s.description = 'In browser database managment tool for Postgres databases.'\
                  'View your app\'s database right from your browser.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*',
                'MIT-LICENSE',
                'Rakefile',
                'README.rdoc']

  s.add_dependency 'rails', '~> 4.1.6'
  s.add_dependency 'pg'
  s.add_dependency 'pg-hstore'
  s.add_dependency 'net-ssh-gateway'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'font-awesome-sass'

  s.add_development_dependency 'rspec-rails'
end
