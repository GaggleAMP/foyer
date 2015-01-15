require 'foyer/version'
require 'foyer/engine'
require 'foyer/rails'

module Foyer
  # Class variables are required for the implementation of this class.
  # rubocop:disable Style/ClassVars

  mattr_accessor :identity_provider
  @@identity_provider = :gaggleamp

  mattr_accessor :session_key
  @@session_key = 'foyer.authenticated_user'

  mattr_accessor :user_finder
  @@user_finder = ->(_) { fail 'Override this method' }

  mattr_accessor :token_finder
  @@token_finder = ->(_) { fail 'Override this method' }

  # rubocop:enable Style/ClassVars

  module Controller
    autoload :Helpers, 'foyer/controller/helpers'
  end

  module Grape
    autoload :Helpers, 'foyer/grape/helpers'
  end

  autoload :OmniauthCallbacksController, 'foyer/omniauth_callbacks_controller'

  autoload :TestHelpers, 'foyer/test_helpers'
end
