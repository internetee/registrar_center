require 'rails_helper'

# Since HTTP request params are differ from method call arguments (e.g. we cannot use
# reserved keyword `until`), we are overriding method prepare_method_params(params) here
# That's unnecessary if all the keys/values from method call arguments could be passed
# to HTTP request
def prepare_method_params(params)
  let(:method_params) {
    {
      detailed: params[:detailed],
      from_date: params[:from],
      until_date: params[:until]
    }
  }
end

RSpec.describe ApiConnector::BalanceChecker do
  it_behaves_like "Token generator"

  context 'with empty params' do
    params = {
        detailed: false,
        from: nil,
        until: nil,
      }
    include_context 'Request sender', options(params)
    check_sending_request(method: :check_balance, params: params)
  end

  context 'with set params' do
    params = {
      detailed: true,
      from: 10.days.ago,
      until: 10.days.from_now,
    }
    include_context 'Request sender', options(params)
    check_sending_request(method: :check_balance, params: params)
  end
end
