require 'ostruct'

class SessionsController < ActionController::Base
  include Foyer::Controller::Helpers

  def developer
    sign_in OpenStruct.new.tap { |i| i.id = rand(10000) }

    head :no_content
  end
end
