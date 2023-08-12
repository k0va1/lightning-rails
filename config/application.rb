# frozen_string_literal: true

require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module RapidRails
  class Application < Rails::Application
    Dir[Rails.root.join("lib/middleware/**/*.{rb}")].sort .each { |file| require file }

    config.load_defaults 7.0

    config.active_job.queue_adapter = :sidekiq

    config.generators do |g|
      g.test_framework :rspec, fixtures: false, view_specs: false, helper_specs: false,
        routing_specs: false, request_specs: false, controller_specs: false
    end
  end
end
