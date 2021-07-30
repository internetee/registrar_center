# frozen_string_literal: true

class ApiConnector
  module BulkActions
    class NameserverChange < ApiConnector
      include EndpointRequestable
      ACTION = 'replace_nameserver'
      ENDPOINT = {
        method: 'put',
        endpoint: '/registrar/nameservers',
      }.freeze

      def replace_nameserver(payload: nil)
        request(url: endpoint_url, method: method, params: replace_nameserver_params(payload))
      end

      private

      def replace_nameserver_params(payload)
        {
          data: {
            type: 'nameserver',
            id: payload[:id],
            domains: payload[:domains],
            attributes: {
              hostname: payload[:attributes][:hostname],
              ipv4: payload[:attributes][:ipv4],
              ipv6: payload[:attributes][:ipv6],
            },
          },
        }
      end
    end
  end
end
