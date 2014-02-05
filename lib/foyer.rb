require 'foyer/version'
require 'foyer/engine'
require 'foyer/rails'

module Foyer
  mattr_accessor :identity_provider
  @@identity_provider = :gaggleamp

  mattr_accessor :session_key
  @@session_key = 'foyer.authenticated_user'

  mattr_accessor :user_finder
  @@user_finder = lambda { |_| raise 'Override this method' }

  module Controller
    autoload :Helpers, 'foyer/controller/helpers'
  end

  autoload :OmniauthCallbacksController, 'foyer/omniauth_callbacks_controller'

  autoload :TestHelpers, 'foyer/test_helpers'
end
