module Foyer
  module Grape
    module Helpers
      extend ActiveSupport::Concern
      include Foyer::API::Helpers

      protected

      def current_user
        return nil unless headers['Authorization'] =~ /^Bearer (.*)/m
        @current_user ||= Foyer.token_finder.call(Regexp.last_match[1])
      end

      def authenticate_user!
        error!('Unauthorized', 401) unless user_signed_in?
      end
    end
  end
end
