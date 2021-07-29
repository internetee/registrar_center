# frozen_string_literal: true

class ApiConnector
  module Dnssec
    class All < ApiConnector
      include EndpointRequestable
      ACTION = 'load_all_dnssec_keys'
      ENDPOINT = {
        method: 'get',
        endpoint: '/domains',
      }.freeze

      def load_all_dnssec_keys(domain_name: '')
        request(url: url_with_id(domain_name), method: method)
      end

      private

      def url_with_id(domain_name)
        "#{endpoint_url}/#{domain_name}/dnssec"
      end
    end
  end
end
