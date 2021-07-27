require 'rails_helper'

RSpec.describe ApiConnector::Contacts::Creator do
  it_behaves_like "Token generator"

  payload = {
    name: Faker::Name.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone,
    ident: {
      ident: 'xxx',
      ident_type: 'priv',
      ident_country_code: 'EE',
    }
  }

  options = {
    request_params: { contact: payload },
    method_params: { payload: payload },
    check_with_params: true
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
