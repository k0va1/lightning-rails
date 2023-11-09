# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "bootsnap", require: false
gem "bundler-audit"
gem "counter_culture", "~> 2.0"
gem "hotwire-livereload", "~> 1.2", group: :development
gem "jsbundling-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0"
gem "redis", "~> 4.0"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 2.0"
gem "turbo-rails"

gem "sidekiq"
gem "sidekiq-scheduler"

group :development, :test do
  gem "bullet", "~> 7.0.0"
  gem "debug"
  gem "factory_bot_rails"
  gem "faker"
  gem "standard"
end

group :development do
  gem "annotate"
  gem "colorize"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "database_cleaner-active_record"
  gem "rspec-rails", "~> 6.0.0"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 5.0"
  gem "simplecov", require: false
  gem "webmock"
end
