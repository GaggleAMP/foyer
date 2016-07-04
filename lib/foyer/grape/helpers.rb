module Foyer
  module Grape
    module Helpers
      extend ActiveSupport::Concern
      include Foyer::API::Helpers

      protected

      def authenticate_user!
        error!('Unauthorized', 401) unless user_signed_in?
      end
    end
  end
end
