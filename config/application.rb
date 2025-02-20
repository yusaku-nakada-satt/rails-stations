require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # for rspec
    # Setting it to false will prevent unnecessary test files from being created.
    config.generators do |g|
      g.test_framework false
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # デフォルトの言語を日本語に設定
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'

    # productionの環境日付でないのでlogに日付出力
    config.log_formatter = Logger::Formatter.new
  end
end
