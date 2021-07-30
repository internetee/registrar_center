# frozen_string_literal: true

class ApiConnector
  module Domains
    class All < ApiConnector
      include EndpointRequestable
      ENDPOINT = {
        method: 'get',
        endpoint: '/domains',
      }.freeze
      ACTION = 'load_all_domains'

      def load_all_domains
        request(url: endpoint_url, method: method)
      end
    end
  end
end
