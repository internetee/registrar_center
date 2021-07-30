require 'rails_helper'

RSpec.describe ApiConnector::Dnssec::Creator do
  it_behaves_like "Token generator"

  domain_name = Faker::Internet.domain_name
  payload = {
    dns_keys: [{
                 flags: [256, 257].sample,
                 protocol: 3,
                 alg: [3,5,6,7,8,10,13,14].sample,
                 public_key: Faker::Crypto.sha256,
               }],
  }

  options = {
    request_params: payload,
    method_params: { payload: payload, domain_name: domain_name },
    check_with_params: true,
    add_to_url: "/#{domain_name}/dnssec",
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
