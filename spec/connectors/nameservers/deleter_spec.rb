require 'rails_helper'

RSpec.describe ApiConnector::Nameservers::Deleter do
  it_behaves_like "Token generator"

  domain_name = Faker::Internet.domain_name
  nameserver_hostname = Faker::Internet.domain_name
  options =
    {
      method_params: {
        domain_name: domain_name,
        nameserver_hostname: nameserver_hostname,
      },
      check_with_params: true,
      add_to_url: "/#{domain_name}/nameservers/#{nameserver_hostname}",
    }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
