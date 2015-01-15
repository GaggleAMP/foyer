require 'spec_helper'

describe Foyer::Grape::Helpers do
  class IncludesFoyerGrapeHelpers
    def headers
      @headers ||= { 'Authorization' => 'Bearer _' }
    end

    include Foyer::Grape::Helpers
  end

  subject { IncludesFoyerGrapeHelpers.new }

  describe '.set_token_finder' do
    it 'sets the :token_finder configuration to the provided block' do
      expect {
        subject.class_eval do
          set_token_finder do |token|
            token
          end
        end
      }.to change(Foyer, :token_finder)
    end
  end

  describe '#current_user' do
    it 'calls the token_finder method' do
      @called = false
      Foyer.token_finder = lambda { |_| @called = true }

      subject.send :current_user

      expect(@called).to eq true
    end
  end
end
