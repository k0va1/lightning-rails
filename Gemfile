# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.6"

gem "bootsnap", require: false
gem "bundler-audit"
gem "counter_culture", "~> 2.0"
gem "jsbundling-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 6.4"
gem "rails", "~> 8.0.1"
gem "redis", "~> 4.0"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 2.0"
gem "turbo-rails"

gem "sidekiq"
gem "sidekiq-scheduler"

gem "strong_migrations"

group :development, :test do
  gem "bullet", "~> 8.0.0"
  gem "debug"
  gem "factory_bot_rails"
  gem "faker"
  gem "standard"
  gem "erb_lint", require: false
end

group :development do
  gem "annotaterb"
  gem "colorize"
  gem "web-console"
  gem "hotwire-livereload", "~> 1.2"
end

group :test do
  gem "capybara"
  gem "database_cleaner-active_record"
  gem "cuprite"
  gem "rspec-rails", "~> 6.0.0"
  gem "shoulda-matchers", "~> 5.0"
  gem "simplecov", require: false
  gem "webmock"
end
