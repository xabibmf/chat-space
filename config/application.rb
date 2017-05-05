require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ChatSpace
  class Application < Rails::Application
    config.generators do |g|
      g.javascripts false
      g.helper false
      g.test_framework false
    end

    config.i18n.default_locale = :ja

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end
