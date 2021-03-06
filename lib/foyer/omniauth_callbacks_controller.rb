module Foyer
  class OmniauthCallbacksController < ActionController::Base
    include Controller::Helpers

    def passthru
      head :not_found
    end

    def failure
      fail NotImplementedError
    end

    def callback
      fail NotImplementedError
    end

    protected

    def after_sign_in_path
      return origin if origin.to_s.match(%r{^\/}) || origin.to_s.match(%r{^#{request.scheme}://#{request.host}})
      root_path
    end

    private

    def origin
      request.env['omniauth.origin']
    end

    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
