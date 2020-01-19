source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'bcrypt', '~> 3.1.13'
gem 'graphql', '~> 1.9.17'
gem 'jwt', '~> 2.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors', '~> 1.1.1'
gem 'rails', '~> 6.0.2.1'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'bullet', '~> 6.0.2'
  gem 'faker', github: 'faker-ruby/faker', branch: 'master'
  gem 'pry-byebug', '~> 3.7.0'
  gem 'rspec-rails', '~> 3.9.0'
end

group :development do
  gem 'graphiql-rails', '~> 1.7.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '~> 0.79', require: false
  gem 'rubocop-performance', '~> 1.5.2', require: false
  gem 'rubocop-rails', '~> 2.4.1', require: false
  gem 'rubocop-rspec', '~> 1.37.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner', '~> 1.7.0'
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'shoulda-matchers', '~> 4.2.0'
  gem 'simplecov', '~> 0.17.1', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
