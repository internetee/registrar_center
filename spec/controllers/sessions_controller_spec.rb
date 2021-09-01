require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  context 'actions' do
    describe 'GET #new' do
      it "has a 200 status code" do
        get :new
        expect(response.status).to eq(200)
      end
    end
  end

  context 'view rendering' do
    describe 'with correct username and password' do
      before do
        allow_any_instance_of(AuthChecker).to receive(:check_auth).and_return(success_result)
      end

      it "returns 200" do
        post :create, params: params
        expect(response.status).to eq(200)
      end
    end

    describe 'with incorrect username and password' do
      before do
        allow_any_instance_of(AuthChecker).to receive(:check_auth).and_return(failed_result)
      end

      it "returns 403" do
        post :create, params: params
        expect(response.status).to eq(403)
      end
    end

    def success_result
      OpenStruct.new(
        authenticated: true,
        code: 200,
        message: 'some message',
        uuid: SecureRandom.uuid,
      )
    end

    def failed_result
      OpenStruct.new(
        authenticated: false,
        code: 200,
        message: 'some message',
        uuid: SecureRandom.uuid,
        )
    end

    def params
      { username: '123', password: '123' }
    end
  end
end
