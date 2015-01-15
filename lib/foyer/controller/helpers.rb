module Foyer
  module Controller
    module Helpers
      extend ActiveSupport::Concern

      included do
        helper_method :current_user, :user_signed_in?
      end

      protected
      def sign_in(user)
        session[Foyer.session_key] = {
          id: user.id,
          current_sign_in_at: Time.now,
          current_sign_in_ip: request.ip,
        }.with_indifferent_access
      end

      def sign_out
        session.delete(Foyer.session_key)
      end

      def user_signed_in?
        user_session.present? and current_user.present?
      end

      def current_user
        return nil unless user_session.present?
        @current_user ||= Foyer.user_finder.call(user_session[:id])
      end

      def user_session
        session[Foyer.session_key] ||= {}
        session[Foyer.session_key] = session[Foyer.session_key].with_indifferent_access
        session[Foyer.session_key]
      end

      def authenticate_user!
        unless user_signed_in?
          redirect_to "/auth/#{Foyer.identity_provider}?origin=#{CGI.escape request.fullpath}"
        end
      end

      module ClassMethods
        def set_user_finder(&blk)
          if blk.arity != 1
            raise ':user_finder must accept 1 argument (user_id)'
          end
          Foyer.user_finder = blk
        end
      end
    end
  end
end
