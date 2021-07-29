require 'rails_helper'

RSpec.describe ApiConnector::Transfers::Creator do
  it_behaves_like "Token generator"

  domain_name = Faker::Internet.domain_name
  payload = { transfer_code: Faker::Crypto.md5 }

  options = {
    request_params: { transfer: payload },
    method_params: { payload: payload, domain_name: domain_name },
    check_with_params: true,
    add_to_url: "/#{domain_name}/transfer",
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
