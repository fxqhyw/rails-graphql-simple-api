require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_text/engine'
require 'action_view/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookApi
  class Application < Rails::Application
    config.load_defaults 6.0

    config.api_only = true

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
