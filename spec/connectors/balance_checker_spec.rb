require 'rails_helper'

RSpec.describe ApiConnector::BalanceChecker do
  it_behaves_like "Token generator"

  context 'with empty params' do
    params = {
        detailed: false,
        from: nil,
        until: nil,
      }

    options = {
      request_params: params,
      check_with_params: false,
    }
    it_behaves_like 'Request sender', options
  end

  context 'with set params' do
    params = {
      detailed: true,
      from: 10.days.ago,
      until: 10.days.from_now,
    }
    options = {
      request_params: params,
      method_params: params,
      check_with_params: true,
    }
    it_behaves_like 'Request sender', options
  end
end
