require 'spec_helper'

describe Foyer::API::Helpers do
  class IncludesFoyerAPIHelpers
    def headers
      @headers ||= { 'Authorization' => 'Bearer _' }
    end

    include Foyer::API::Helpers
  end

  subject { IncludesFoyerAPIHelpers.new }

  describe '.set_token_finder' do
    it 'sets the :token_finder configuration to the provided block' do
      expect do
        subject.class_eval do
          set_token_finder do |token|
            token
          end
        end
      end.to change(Foyer, :token_finder)
    end
  end

  describe '#current_user' do
    it 'calls the token_finder method' do
      @called = false
      Foyer.token_finder = ->(_) { @called = true }

      subject.send :current_user

      expect(@called).to eq true
    end
  end
end
