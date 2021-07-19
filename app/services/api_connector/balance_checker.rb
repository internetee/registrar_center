# frozen_string_literal: true

class ApiConnector
  module BalanceChecker
    ACTION = 'check_balance'

    def check_balance(detailed: false, from_date: nil, until_date: nil)
      params = {
        detailed: detailed,
        from: from_date,
        until: until_date,
      }
      request = request(url: endpoint_url, params: params)
      response = request.send('get')
      JSON.parse(response.body)
    end
  end
end
