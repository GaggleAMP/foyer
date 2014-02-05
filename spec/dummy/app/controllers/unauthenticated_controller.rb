class UnauthenticatedController < ApplicationController
  def index
    render text: 'success'
  end
end
