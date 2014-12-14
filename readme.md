# Pancakes
## About
Pancakes is a postgres database editor in your browser, heavily inspired by Sequel Pro.
It's intended to only be used in development, though it's able to access databases for all the defined enviroments in your Rails project.

## Install
To use pancakes in your project simply add the following line to your Gemfile
```RUBY
gem 'pancakes'
```
Afterwards open your terminal application, go to the root of your Rails project and run the following commands
```BASH
bundle install
rails pancakes:install
```
This will create a `pancakes.yml` file in the `config/` folder and add it to the `.gitignore` file.

## Settings
To override the default settings modify the `config/pancakes.yml` file.

## Contributing
If you would like to contribute to this project:

1. Ensure you have a Postgres database on which you can run tests on

2. Fork the project

3. Add/modify the code

4. Write tests for any modifications you make

5. Make sure all tests pass

6. Issue a pull request
