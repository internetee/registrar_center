require 'rails_helper'

RSpec.describe ApiConnector::Contacts::Updater do
  it_behaves_like "Token generator"

  payload = {
    name: Faker::Name.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone,
  }
  message_id = Faker::Number.positive(from: 1, to: 1000)

  options = {
    request_params: { contact: payload },
    method_params: { payload: payload, id: message_id },
    check_with_params: true,
    add_to_url: "/#{message_id}",
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
