require 'rails_helper'

def prepare_method_params(params)
  let(:method_params) {
    {
      detailed: params[:detailed],
      from_date: params[:from],
      until_date: params[:until]
    }
  }
end

def prepare_options(params)
  {
    klass: ApiConnector::BalanceChecker,
    params: params,
  }
end

RSpec.describe ApiConnector::BalanceChecker do
  it_behaves_like "Token generator", ApiConnector::BalanceChecker

  context 'with empty params' do
    params = {
        detailed: false,
        from: nil,
        until: nil,
      }

    prepare_method_params(params)

    opts = prepare_options(params)

    include_context 'Request sender', opts

    it 'can send requests' do
      conn = ApiConnector::BalanceChecker.new(username: 'aa', password: 'bb')
      conn.check_balance(**method_params)
    end
  end

  context 'with set params' do
    params = {
      detailed: true,
      from: 10.days.ago,
      until: 10.days.from_now,
    }

    prepare_method_params(params)

    opts = prepare_options(params)

    include_context 'Request sender', opts

    it 'can send requests' do
      conn = ApiConnector::BalanceChecker.new(username: 'aa', password: 'bb')
      conn.check_balance(**method_params)
    end
  end
end
