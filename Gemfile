# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "redis", "~> 4.0"
gem "bootsnap", require: false
gem "hotwire-livereload", "~> 1.2", group: :development
gem "tailwindcss-rails", "~> 2.0"
gem "mrsk", "~> 0.14.0"
gem "bundler-audit"
gem "counter_culture", "~> 2.0"

gem "sidekiq"
gem "sidekiq-scheduler"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "bullet", "~> 7.0.0"
  gem "faker"
  gem "rails-lint"
end

group :development do
  gem "web-console"
  gem "annotate"
  gem "colorize"
end

group :test do
  gem "rspec-rails", "~> 6.0.0"
  gem "capybara"
  gem "shoulda-matchers", "~> 5.0"
  gem "database_cleaner-active_record"
  gem "simplecov", require: false
  gem "selenium-webdriver"
  gem "webmock"
end
