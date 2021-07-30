require 'rails_helper'

RSpec.describe ApiConnector::BulkActions::DomainRenew do
  it_behaves_like "Token generator"

  domains = []
  3.times do
    domains << Faker::Internet.domain_name
  end

  period_unit = %w(y m).sample
  period = Faker::Number.positive(from: 1, to: 10).to_s
  renew_period = period + period_unit

  payload = {
    domains: domains,
    renew_period: renew_period,
  }

  options = {
    request_params: payload,
    method_params: { payload: payload },
    check_with_params: true
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
