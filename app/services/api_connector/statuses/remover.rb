# frozen_string_literal: true

class ApiConnector
  module Statuses
    class Remover < ApiConnector
      include EndpointRequestable
      ACTION = 'remove_client_hold'
      ENDPOINT = {
        method: 'delete',
        endpoint: '/domains',
      }.freeze

      def remove_client_hold(domain_name: '')
        request(url: url_with_id(domain_name), method: method)
      end

      private

      def url_with_id(domain_name)
        "#{endpoint_url}/#{domain_name}/statuses/client_hold"
      end
    end
  end
end
