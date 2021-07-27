# frozen_string_literal: true

class ApiConnector
  class BalanceChecker < ApiConnector
    include EndpointRequestable
    ACTION = 'check_balance'

    def check_balance(detailed: false, from: nil, until: nil)
      params = {
        detailed: detailed,
        from: from,
        until: binding.local_variable_get(:until),
      }
      request(url: endpoint_url, params: params, method: method)
    end
  end
end
