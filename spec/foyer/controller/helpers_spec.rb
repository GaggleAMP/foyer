require 'spec_helper'

describe Foyer::Controller::Helpers do
  class IncludesFoyerControllerHelpers
    def self.helper_method(*)
      nil
    end

    def session
      @session ||= {}
    end

    include Foyer::Controller::Helpers
  end

  subject { IncludesFoyerControllerHelpers.new }

  describe '.set_user_finder' do
    it 'sets the :user_finder configuration to the provided block' do
      expect do
        subject.class_eval do
          set_user_finder do |user_id|
            user_id
          end
        end
      end.to change(Foyer, :user_finder)
    end
  end

  describe '#current_user' do
    it 'calls the user_finder method' do
      @called = false
      subject.send(:user_session)[:id] = '_'
      Foyer.user_finder = ->(_) { @called = true }

      subject.send :current_user

      expect(@called).to eq true
    end
  end
end
