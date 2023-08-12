# frozen_string_literal: true

require "sidekiq/web"

if Rails.env.production?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(username),
                                                Digest::SHA256.hexdigest(Rails.application.credentials.sidekiq_admin_name)) &
    ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(password),
                                                Digest::SHA256.hexdigest(Rails.application.credentials.sidekiq_admin_password))
  end
end

Rails.application.routes.draw do
  root "home#index"

  # TODO: remove after Rails 7.1
  get "/up" => "health#show"

  namespace :admin do
    mount Sidekiq::Web => "/sidekiq"
  end
end
