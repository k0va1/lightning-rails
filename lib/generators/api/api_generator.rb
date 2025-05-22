class ApiGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def modify_gemfile
    if behavior == :invoke
      gem "alba"
      gem "oj"
    elsif behavior == :revoke
      say_status("remove", "Removing gems from Gemfile manually...", :red)
      gsub_file "Gemfile", /^\s*gem ["']alba["'].*\n/, "", force: true
      gsub_file "Gemfile", /^\s*gem ["']oj["'].*\n/, "", force: true
    end
  end

  def bundle_install
    Bundler.with_unbundled_env do
      system "bundle install --quiet"
    end
  end

  def copy_api_files
    directory "controllers", "app/controllers"
    directory "serializers", "app/serializers"

    if behavior == :revoke
      remove_dir "app/controllers/v1"
      remove_dir "app/serializers"
    end

    copy_file "initializers/alba.rb", "config/initializers/alba.rb"
  end

  def add_api_routes
    route %(scope module: "v1", path: "v1", constraints: {format: "json"} do\nend)
  end
end
