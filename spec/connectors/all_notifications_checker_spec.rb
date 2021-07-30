require 'rails_helper'

RSpec.describe ApiConnector::AllNotificationsChecker do

  it_behaves_like 'Token generator'

  context 'empty params' do
    options = {
      request_params: described_class::DEFAULT_PARAMS,
      check_with_params: false,
    }

    it_behaves_like 'Request sender', options
  end

  context 'with params set' do
    params= {
      limit: Faker::Number.positive(from: 1, to: 500),
      offset: Faker::Number.positive(from: 1, to: 500),
    }

    options = {
      request_params: params,
      method_params: params,
      check_with_params: true,
    }

    it_behaves_like 'Request sender', options
  end
end
