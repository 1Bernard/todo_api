require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TodoApi
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])
    config.api_only = true

    # Solid Queue configuration
    config.active_job.queue_adapter = :solid_queue
    config.solid_queue.connects_to = { 
      database: { writing: Rails.env.production? ? :queue : :primary }
    }

    # Session middleware for Action Cable
    config.session_store :cookie_store, key: '_todo_api_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options

    # Autoload paths
    config.autoload_paths += %W[#{config.root}/app/services/**/*]
    config.autoload_paths += %W[#{config.root}/app/policies/**/*]
    config.autoload_paths += %W[#{config.root}/app/serializers/**/*]
  end
end
