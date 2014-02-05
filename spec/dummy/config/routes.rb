Rails.application.routes.draw do

  post '/sign_in' => 'sessions#developer'

  get '/authenticated' => "authenticated#index"

  authenticate do
    get '/authenticated_by_route_constraint' => 'unauthenticated#index'
  end

  authenticate lambda { |user| false } do
    get '/authenticated_by_route_constraint_which_blocks_all_users' => 'unauthenticated#index'
  end
end
