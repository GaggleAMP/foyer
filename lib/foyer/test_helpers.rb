module Foyer
  module TestHelpers
    def sign_in(user)
      session[Foyer.session_key] = { id: 4 }
    end

    def sign_out
      session.delete Foyer.session_key
    end
  end
end
