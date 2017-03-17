require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'

require 'foyer'

module Dummy
  class Application < Rails::Application
    config.cache_classes = true
    config.eager_load = false
    config.action_dispatch.show_exceptions = false
    config.active_support.deprecation = :stderr
    config.log_level = :fatal
    config.logger = ActiveSupport::Logger.new(STDERR)
  end
end
