class UnauthenticatedController < ApplicationController
  def index
    render body: 'success'
  end
end
