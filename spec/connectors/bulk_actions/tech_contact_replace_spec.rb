require 'rails_helper'

RSpec.describe ApiConnector::BulkActions::TechContactReplace do
  it_behaves_like "Token generator"

  payload = {
    current_contact_id: Faker::Number.positive(from: 1, to: 1000000),
    new_contact_id: Faker::Number.positive(from: 1, to: 1000000),
  }

  options = {
    request_params: payload,
    method_params: { payload: payload },
    check_with_params: true
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
