# frozen_string_literal: true

class ApiConnector
  module Transfers
    class Creator < ApiConnector
      include EndpointRequestable
      ACTION = 'create_transfer'
      ENDPOINT = {
        method: 'post',
        endpoint: '/domains',
      }.freeze

      def create_transfer(payload: nil, domain_name: '')
        request(url: url_with_id(domain_name), method: method, params: domain_params(payload))
      end

      private

      def url_with_id(domain_name)
        "#{endpoint_url}/#{domain_name}/transfer"
      end

      def domain_params(payload)
        {
          transfer: {
            transfer_code: payload[:transfer_code],
          },
        }
      end
    end
  end
end
