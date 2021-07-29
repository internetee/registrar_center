# frozen_string_literal: true

class ApiConnector
  module Dnssec
    class Deleter < ApiConnector
      include EndpointRequestable
      ACTION = 'delete_dnssec_keys'
      ENDPOINT = {
        method: 'delete',
        endpoint: '/nameservers',
      }.freeze

      def delete_dnssec_keys(payload: nil, domain_name: '')
        request(url: url_with_id(domain_name), method: method, params: domain_params(payload))
      end

      private

      def url_with_id(domain_name)
        "#{endpoint_url}/#{domain_name}/dnssec"
      end

      def domain_params(payload)
        {
          dns_keys: payload[:dns_keys].each do |dns_key| # Array of attrs
            {
              flags: dns_key[:flags],
              protocol: dns_key[:protocol],
              alg: dns_key[:alg],
              public_key: dns_key[:public_key],
            }
          end
        }
      end
    end
  end
end
