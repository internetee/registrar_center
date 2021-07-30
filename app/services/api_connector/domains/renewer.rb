# frozen_string_literal: true

class ApiConnector
  module Domains
    class Renewer < ApiConnector
      include EndpointRequestable
      ACTION = 'renew_domain'
      ENDPOINT = {
        method: 'post',
        endpoint: '/domains',
      }.freeze

      def renew_domain(payload: nil, domain_name: '')
        request(url: url_with_id(domain_name), method: method, params: domain_params(payload))
      end

      private

      def url_with_id(domain_name)
        "#{endpoint_url}/#{domain_name}/renew"
      end

      def domain_params(payload)
        {
          renew: {
            period: payload[:period],
            period_unit: payload[:period_unit],
            exp_date: payload[:exp_date],
          },
        }
      end
    end
  end
end
