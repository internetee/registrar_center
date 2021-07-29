# frozen_string_literal: true

class ApiConnector
  module Nameservers
    class Creator < ApiConnector
      include EndpointRequestable
      ACTION = 'create_nameservers'
      ENDPOINT = {
        method: 'post',
        endpoint: '/domains',
      }.freeze

      def create_nameservers(payload: nil, domain_name: '')
        request(url: url_with_id(domain_name), method: method, params: domain_params(payload))
      end

      private

      def url_with_id(domain_name)
        "#{endpoint_url}/#{domain_name}/nameservers"
      end

      def domain_params(payload)
        {
          nameservers: payload[:nameservers].map do |ns_attr| # Array of attrs
            {
              hostname: ns_attr[:hostname],
              ipv4: ns_attr[:ipv4],
              ipv6: ns_attr[:ipv6],
            }
          end,
        }
      end
    end
  end
end
