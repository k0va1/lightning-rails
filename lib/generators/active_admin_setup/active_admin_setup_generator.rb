class ActiveAdminSetupGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  class_option :with_devise, type: :boolean, default: false

  def run_active_admin_generator
    gem "sassc-rails"
    gem "activeadmin"

    if options[:with_devise]
      gem "devise"
      generate "active_admin:install"
    else
      generate "active_admin:install --skip-users"
    end

    rails_command "db:migrate"
    rails_command "db:seed"
  end
end
