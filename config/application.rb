require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Spis
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.time_zone = 'Asia/Manila'
    config.active_record.default_timezone = :utc
    config.beginning_of_week = :sunday
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end
