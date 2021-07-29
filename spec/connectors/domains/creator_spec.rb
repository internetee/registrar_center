require 'rails_helper'

RSpec.describe ApiConnector::Domains::Creator do
  it_behaves_like "Token generator"

  payload = {
    name: Faker::Internet.domain_name,
    reserved_pw: Faker::Internet.password,
    transfer_code: Faker::Internet.password,
    registrant: Faker::Lorem.word,
    period_unit: %w[m y].sample,
    period: Faker::Number.positive(from: 1, to: 5),
    admin_contact: [Faker::Lorem.word],
    tech_contact: [Faker::Lorem.word],
    nameserver_attributes: [{
      hostname: "ns1.#{Faker::Internet.domain_name}",
      ipv4: Faker::Internet.ip_v4_address,
      ipv6: Faker::Internet.ip_v6_address
                            }],
    dnskey_attributes: [{
      flags: [256, 257].sample,
      protocol: 3,
      alg: [3,5,6,7,8,10,13,14].sample,
      public_key: Faker::Crypto.sha256,
    }],
  }

  options = {
    request_params: { domain: payload },
    method_params: { payload: payload },
    check_with_params: true
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
