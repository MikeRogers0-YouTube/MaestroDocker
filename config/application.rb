require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsDeployingApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Don't generate files we don't like.
    config.generators do |g|
      g.helper false
      g.assets false
      g.helper false
      g.view_specs false
      g.decorator false
      g.jbuilder false
      g.api false
      g.system_tests = nil
    end
  end
end
