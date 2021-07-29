# frozen_string_literal: true

class ApiConnector
  module Nameservers
    class All < ApiConnector
      include EndpointRequestable
      ACTION = 'load_all_nameservers'
      ENDPOINT = {
        method: 'get',
        endpoint: '/domains',
      }.freeze

      def load_all_nameservers(domain_name: '')
        request(url: url_with_id(domain_name), method: method)
      end

      private

      def url_with_id(domain_name)
        "#{endpoint_url}/#{domain_name}/nameservers"
      end
    end
  end
end
