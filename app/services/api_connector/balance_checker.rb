# frozen_string_literal: true

class ApiConnector
  class BalanceChecker < ApiConnector
    ACTION = 'check_balance'

    def check_balance(detailed: false, from_date: nil, until_date: nil)
      params = {
        detailed: detailed,
        from: from_date,
        until: until_date,
      }
      request(url: endpoint_url, params: params, method: method)
    end

    private

    def endpoint_url
      endpoint(ACTION)
    end

    def method
      request_method(ACTION)
    end
  end
end
