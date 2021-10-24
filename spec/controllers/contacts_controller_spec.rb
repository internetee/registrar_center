require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  options = [
    {
      method: :index,
      http_method: :get,
    },
    {
      method: :show,
      http_method: :get,
      params: {
        id: 115582124,
      }
    },
    {
      method: :destroy,
      http_method: :delete,
      params: {
        id: 115582124,
      },
    },
    {
      method: :update,
      http_method: :put,
      params: {
        id: 115582124,
        name: Faker::Name.name,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number
      }
    },
    {
      method: :create,
      http_method: :post,
      params: {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number,
        ident: 'xxx',
        ident_type: 'priv',
        ident_country_code: 'EE',
      }
    },
    {
      method: :check,
      http_method: :get,
      params: {
        id: 115582124,
      }
    }
  ]

  it_behaves_like "Base controller with auth", options

  context 'Show method with non-existent ID' do
    it 'should return to #index with 404 error' do
      pending 'test not implemented yet, should use another VCR cassette'

      get :show, params: { id: Faker::Number.positive }
      expect(response.status).to eq(404)
    end
  end

  context 'Update method with non-existent ID' do
    it 'should return to #index with 404 error' do
      pending 'test not implemented yet, should use another VCR cassette'

      put :update, params: { id: Faker::Number.positive }
      expect(response.status).to eq(404)
    end
  end
end
