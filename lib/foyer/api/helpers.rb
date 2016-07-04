module Foyer
  module API
    module Helpers
      extend ActiveSupport::Concern

      protected

      def user_signed_in?
        current_user.present?
      end

      def current_user
        return nil unless request.authorization.to_s =~ /^Bearer (.*)/m
        @current_user ||= Foyer.token_finder.call(Regexp.last_match[1])
      end

      def authenticate_user!
        head :unauthorized unless user_signed_in?
      end

      module ClassMethods
        def set_token_finder(&blk) # rubocop:disable Style/AccessorMethodName
          fail ':token_finder must accept 1 argument (token)' unless blk.arity == 1
          Foyer.token_finder = blk
        end
      end
    end
  end
end
