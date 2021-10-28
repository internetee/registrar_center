# frozen_string_literal: true

class ApiConnector
  module Domains
    class Deleter < ApiConnector
      include EndpointRequestable
      ACTION = 'delete_domain'
      ENDPOINT = {
        method: 'delete',
        endpoint: '/domains',
      }.freeze

      def delete_domain(payload: nil, domain_name: '')
        request(url: url_with_id(domain_name),
                method: method,
                params: domain_params(payload),
                headers: add_headers(payload))
      end

      private

      def domain_params(payload)
        {
          delete: {
            verified: payload[:verified],
          },
        }
      end

      def add_headers(payload)
        # binding.pry
        { 'Auth-Code' => payload[:auth_code] } if payload && payload[:auth_code]
      end
    end
  end
end
