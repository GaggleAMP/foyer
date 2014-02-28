require 'spec_helper'

module Foyer
  describe OmniauthCallbacksController, type: :controller do
    describe "#after_sign_in_path" do
      before do
        allow(controller).to receive(:root_path).and_return '/'
      end

      it "defaults to root path" do
        expect(controller.send :after_sign_in_path).to eq('/')
      end

      it "returns omniauth.origin if available" do
        origin = '/some_path'
        @request.env['omniauth.origin'] = origin

        expect(controller.send :after_sign_in_path).to eq(origin)
      end
    end

  end
end
