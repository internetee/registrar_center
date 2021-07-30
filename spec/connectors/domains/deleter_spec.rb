require 'rails_helper'

RSpec.describe ApiConnector::Domains::Deleter do
  it_behaves_like "Token generator"

  domain_name = Faker::Internet.domain_name

  payload = {
    verified: %w(true false).sample,
    auth_code: Faker::Crypto.md5,
  }

  headers = { "Auth-Code" => payload[:auth_code] }

  options =
    {
      request_params: { delete: { verified: payload[:verified] } },
      method_params: { domain_name: domain_name, payload: payload },
      headers: headers,
      check_with_params: true,
      add_to_url: "/#{domain_name}",
    }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
