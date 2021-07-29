require 'rails_helper'

RSpec.describe ApiConnector::Transfers::Reader do
  it_behaves_like "Token generator"

  domain_name = Faker::Internet.domain_name
  options =
    {
      method_params: { domain_name: domain_name },
      check_with_params: true,
      add_to_url: "/#{domain_name}/transfer_info",
    }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
