# frozen_string_literal: true

class ApiConnector
  module Statuses
    class Adder < ApiConnector
      include EndpointRequestable
      ACTION = 'add_client_hold'
      ENDPOINT = {
        method: 'put',
        endpoint: '/domains',
      }.freeze

      def add_client_hold(domain_name: '')
        request(url: url_with_id(domain_name), method: method)
      end

      private

      def url_with_id(domain_name)
        "#{endpoint_url}/#{domain_name}/statuses/client_hold"
      end
    end
  end
end
