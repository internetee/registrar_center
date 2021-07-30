# frozen_string_literal: true

class ApiConnector
  module Nameservers
    class Deleter < ApiConnector
      include EndpointRequestable
      ACTION = 'delete_nameserver'
      ENDPOINT = {
        method: 'delete',
        endpoint: '/nameservers',
      }.freeze

      def delete_nameserver(domain_name: '', nameserver_hostname: '')
        request(url: url_with_id(domain_name: domain_name,
                                 nameserver_hostname: nameserver_hostname),
                method: method)
      end

      private

      def url_with_id(domain_name: '', nameserver_hostname: '')
        "#{endpoint_url}/#{domain_name}/nameservers/#{nameserver_hostname}"
      end
    end
  end
end
