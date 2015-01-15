require 'ostruct'

require 'spec_helper'

describe AuthenticatedController, :type => :controller do
  describe 'not authenticated' do
    it 'redirects to the identity_provider' do
      get :index

      expect(response.location).to match('/auth/gaggleamp')
    end

    it 'sets origin to the location an unauthenticated user was trying to access' do
      get :index

      response.location.split('?').last.tap do |query_string|
        expect(query_string.split('=').first).to eq('origin')
        expect(query_string.split('=').last).to eq(CGI.escape '/authenticated')
      end
    end
  end

  describe 'after authenticating' do
    let(:user) { OpenStruct.new.tap { |i| i.id = rand(10000) } }
    before do
      sign_in user
      Foyer.user_finder = lambda { |_| user }
    end

    it 'allows user to access the action' do
      get :index

      expect(response.status).to eq 200
    end
  end
end
