require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module LightningRails
  class Application < Rails::Application
    config.load_defaults 8.0

    config.active_job.queue_adapter = :sidekiq

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks generators])

    config.generators do |g|
      g.test_framework :rspec, fixtures: false, view_specs: false, helper_specs: false,
        routing_specs: false, request_specs: false, controller_specs: false
    end
  end
end
