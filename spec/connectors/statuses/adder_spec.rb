require 'rails_helper'

RSpec.describe ApiConnector::Statuses::Adder do
  it_behaves_like "Token generator"

  domain_name = Faker::Internet.domain_name
  options =
    {
      method_params: { domain_name: domain_name },
      check_with_params: true,
      add_to_url: "/#{domain_name}/statuses/client_hold",
    }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
