# frozen_string_literal: true

class ApiConnector
  module BulkActions
    class DomainRenew < ApiConnector
      include EndpointRequestable
      ACTION = 'renew'
      ENDPOINT = {
        method: 'post',
        endpoint: '/domains/renew/bulk',
      }.freeze

      def renew(payload: nil)
        request(url: endpoint_url, method: method, params: renew_params(payload))
      end

      private

      def renew_params(payload)
        {
          domains: payload[:domains],
          renew_period: payload[:renew_period],
        }
      end
    end
  end
end
