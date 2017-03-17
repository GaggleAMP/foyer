class AuthenticatedController < ApplicationController
  include Foyer::Controller::Helpers

  before_action :authenticate_user!

  def index
    render body: 'success'
  end
end
