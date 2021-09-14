require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
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
      method: :latest,
      http_method: :get,
    },
  ]

  it_behaves_like "Base controller with auth", options

  context 'Show method with non-existent ID' do
    it 'should return to #index with 404 error' do
      pending 'test not implemented yet, should use another VCR cassette'

      get :show, params: { id: Faker::Number.positive }
      expect(response.status).to eq(404)
    end
  end
end
