require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# load sensitive data for development environment
if Rails.env.development?
ENV.update YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
end

module SkiSite
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
    config.assets.precompile = config.assets.precompile + %w(*.png *.jpg *.jpeg *.gif *.woff *.ttf *.svg *.eot)
    config.assets.precompile += %w( my_js )
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
  config.time_zone = 'Eastern Time (US & Canada)'
  config.action_view.field_error_proc = Proc.new { |html_tag, instance|
    html_tag
  }
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
