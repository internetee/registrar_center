require 'rails_helper'

RSpec.describe ApiConnector::Nameservers::Creator do
  it_behaves_like "Token generator"

  domain_name = Faker::Internet.domain_name
  payload = {
    nameservers: [{
      hostname: "ns1.#{Faker::Internet.domain_name}",
      ipv4: Faker::Internet.ip_v4_address,
      ipv6: Faker::Internet.ip_v6_address
  }],
  }

  options = {
    request_params: payload,
    method_params: { payload: payload, domain_name: domain_name },
    check_with_params: true,
    add_to_url: "/#{domain_name}/nameservers",
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
