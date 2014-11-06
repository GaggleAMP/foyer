require 'ostruct'
require 'spec_helper'

describe "authentication via routes helper", :type => :request do
  it "does not allow an unauthenticated user to access to route" do
    expect {
      get '/authenticated_by_route_constraint'
    }.to raise_error(ActionController::RoutingError)
  end

  it "allows authenticated users to access the route" do
    post '/sign_in'

    get '/authenticated_by_route_constraint'

    expect(response).to be_success
  end

  it "allows only certain users to access the route" do
    Foyer.user_finder = lambda { |user_id| nil }

    post '/sign_in'

    expect {
      get '/authenticated_by_route_constraint_which_blocks_all_users'
    }.to raise_error(ActionController::RoutingError)
  end
end
