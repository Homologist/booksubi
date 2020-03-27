source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.1'
# Use postgres as the database for Active Record
gem 'pg', '~> 0.18.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
#gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Load env variables from .env file
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'

## AWS
#gem 'aws-sdk-core', '~> 3.86'
#gem 'aws-sigv4', '~> 1.1.0', '>= 1.0.0'
#gem 'faraday_middleware', '~> 0.13.1'
#gem 'faraday_middleware-aws-sigv4', '~> 0.2.4'
#
## Linter
#gem 'fasterer', '~> 0.8.0'
#gem 'guard-rubocop', '~> 1.3'
#gem 'rubocop'
#gem 'rubocop-performance', '~> 1.5'
#gem 'rubocop-rails', '~> 2.3', '>= 2.3.2'
#gem 'rubocop-rspec', '~> 1.36'
#gem 'ruby-prof', '~> 1.0'
#
## Monitoring
##gem 'prometheus-client', '~> 1.0.0'
#gem 'flamegraph', '~> 0.9.5'
#gem 'memory_profiler', '~> 0.9.14'
#gem 'rack-mini-profiler', '~> 1.1.4', require: false
#gem 'sentry-raven', '~> 2.13.0', '>= 2.9.0'
#gem 'stackprof', '~> 0.2.15'
#
## Admin
#gem 'activeadmin', '~> 2.5'
#gem 'devise', '~> 4.7.1'
#gem 'inherited_resources', github: 'activeadmin/inherited_resources'
#gem 'pundit', '~> 2.1.0'
#
## Performance tools
#gem 'async', '~> 1.23'
#gem 'concurrent-ruby', '~> 1.1', '>= 1.1.5'

# background
gem 'sidekiq', '~> 6.0.3', '= 6.0.3'

#gem 'tunemygc', '~> 1.0', '>= 1.0.4'
gem 'uuid', '~> 2.3', '>= 2.3.8'

group :development, :test do
# Call 'byebug' anywhere in the code to stop execution and get a debugger console
gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
gem 'letter_opener'
gem 'letter_opener_web'
end

group :development do
# Access an interactive console on exception pages or by calling 'console' anywhere in the code.
gem 'web-console', '>= 3.3.0'
gem 'listen', '>= 3.0.5', '< 3.2'
gem 'reek', '~> 5.6.0', '>= 5.6.0'
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring'
gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
# Adds support for Capybara system testing and selenium driver
gem 'capybara', '>= 2.15'
gem 'cucumber', '~> 3.1', '>= 3.1.2'
gem 'selenium-webdriver'
# Easy installation and use of web drivers to run system tests with browsers
gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
