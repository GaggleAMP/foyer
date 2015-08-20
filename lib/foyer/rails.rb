require 'action_dispatch/routing/mapper'

module ActionDispatch
  module Routing
    class Mapper
      def authenticate(guard = nil)
        constraint = lambda do |request|
          user_id = request.env['rack.session'][Foyer.session_key].try(:with_indifferent_access).try(:[], :id)
          guard.nil? ? true : guard.call(Foyer.user_finder.call(user_id)) if user_id
        end

        constraints(constraint) do
          yield
        end
      end
    end
  end
end
