# frozen_string_literal: true

class ApiConnector
  module Domains
    class Updater < ApiConnector
      include EndpointRequestable
      ACTION = 'update_domain'
      ENDPOINT = {
        method: 'put',
        endpoint: '/domains',
      }.freeze

      def update_domain(payload: nil, domain_name: '')
        request(url: url_with_id(domain_name), method: method, params: domain_params(payload))
      end

      private

      def domain_params(payload)
        {
          domain: {
            registrant: {
              code: payload[:registrant][:code],
              verified: payload[:registrant][:verified],
            },
            transfer_code: payload[:transfer_code],
          },
        }
      end
    end
  end
end
