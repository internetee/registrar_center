# frozen_string_literal: true

class ApiConnector
  module Dnssec
    class Creator < ApiConnector
      include EndpointRequestable
      ACTION = 'create_dnssec_keys'
      ENDPOINT = {
        method: 'post',
        endpoint: '/domains',
      }.freeze

      def create_dnssec_keys(payload: nil, domain_name: '')
        request(url: url_with_id(domain_name), method: method, params: domain_params(payload))
      end

      private

      def url_with_id(domain_name)
        "#{endpoint_url}/#{domain_name}/dnssec"
      end

      def domain_params(payload)
        {
          dns_keys: payload[:dns_keys].map do |dns_key| # Array of attrs
            {
              flags: dns_key[:flags],
              protocol: dns_key[:protocol],
              alg: dns_key[:alg],
              public_key: dns_key[:public_key],
            }
          end,
        }
      end
    end
  end
end
