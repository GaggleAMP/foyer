class AuthenticatedController < ApplicationController
  include Foyer::Controller::Helpers

  before_filter :authenticate_user!

  def index
    render text: 'success'
  end
end
