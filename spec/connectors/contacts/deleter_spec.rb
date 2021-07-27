require 'rails_helper'

RSpec.describe ApiConnector::Contacts::Deleter do
  it_behaves_like "Token generator"

  message_id = Faker::Number.positive(from: 1, to: 1000)
  options =
    {
      method_params: { id: message_id },
      check_with_params: true,
      add_to_url: "/#{message_id}",
    }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
