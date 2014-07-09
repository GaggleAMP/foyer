require 'action_dispatch/routing/mapper'
require 'active_support/hash_with_indifferent_access'

module ActionDispatch::Routing
  class Mapper
    def authenticate(guard=nil)
      constraint = lambda do |request|
        if user_id = request.env['rack.session'][Foyer.session_key].try(:[], :id)
          guard.nil?? true : guard.call(Foyer.user_finder.call(user_id))
        end
      end

      constraints(constraint) do
        yield
      end
    end
  end
end
