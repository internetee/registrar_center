require 'rails_helper'

RSpec.describe ApiConnector::Domains::Renewer do
  it_behaves_like "Token generator"

  payload = {
    period: Faker::Number.positive(from: 1, to: 5),
    period_unit: %w(y m).sample,
    exp_date: Date.today,
  }
  domain_name = Faker::Internet.domain_name

  options = {
    request_params: { renew: payload },
    method_params: { payload: payload, domain_name: domain_name },
    check_with_params: true,
    add_to_url: "/#{domain_name}/renew",
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
