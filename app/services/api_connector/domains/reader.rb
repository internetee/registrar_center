# frozen_string_literal: true

class ApiConnector
  module Domains
    class Reader < ApiConnector
      include EndpointRequestable
      ACTION = 'read_domain'
      ENDPOINT = {
        method: 'get',
        endpoint: '/domains',
      }.freeze

      def read_domain(domain_name: '')
        request(url: url_with_id(domain_name), method: method)
      end
    end
  end
end
