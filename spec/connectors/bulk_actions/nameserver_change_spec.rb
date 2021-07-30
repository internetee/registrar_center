require 'rails_helper'

RSpec.describe ApiConnector::BulkActions::NameserverChange do
  it_behaves_like "Token generator"

  domains = []

  5.times do
    domains << Faker::Internet.domain_name
  end

  payload = {
    type: 'nameserver',
    id: "ns1.#{Faker::Internet.domain_name}",
    domains: domains,
    attributes: {
      hostname: "ns1.#{Faker::Internet.domain_name}",
      ipv4: Faker::Internet.ip_v4_address,
      ipv6: Faker::Internet.ip_v6_address,
    },
  }

  options = {
    request_params: { data: payload },
    method_params: { payload: payload },
    check_with_params: true
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
