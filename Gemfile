# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Devise is a flexible authentication solution for Rails based on Warden. Read more: https://github.com/heartcombo/devise
gem 'devise'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# semantic-ui-sass is an Sass-powered version of Semantic UI. Read more: https://github.com/doabit/semantic-ui-sass
gem 'semantic-ui-sass'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Database Cleaner is a set of gems containing strategies for cleaning your database in Ruby.
  gem 'database_cleaner'
  # factory_bot is a fixtures replacement with a straightforward definition syntax. Read more: https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails'
  # Faker generates fake data. Read more: https://github.com/faker-ruby/faker
  gem 'faker'
  # Adds step-by-step debugging and stack navigation capabilities to pry using byebug.
  gem 'pry-byebug'
  # This gem brings back assigns to controller tests as well as assert_template to both controller and integration tests
  gem 'rails-controller-testing'
  # The RSpec testing framework as a drop-in alternative to its default testing framework, Minitest. Read more: https://github.com/rspec/rspec-rails
  gem 'rspec-rails'
  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality. Read more: https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers'
  # Catch unsafe migrations in development. Read more: https://github.com/ankane/strong_migrations
  gem 'strong_migrations'
end

group :development do
  # The Bullet gem is designed to help you reducing the number of queries it makes. Read more: https://github.com/flyerhzm/bullet
  gem 'bullet'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
