# frozen_string_literal: true

class ApiConnector
  module Domains
    class Creator < ApiConnector
      include EndpointRequestable
      ACTION = 'create_domain'
      ENDPOINT = {
        method: 'post',
        endpoint: '/domains',
      }.freeze

      def create_domain(payload: nil)
        request(url: endpoint_url, method: method, params: domain_params(payload))
      end

      private

      def domain_params(payload)
        {
          domain: {
            name: payload[:name],
            reserved_pw: payload[:reserved_pw],
            transfer_code: payload[:transfer_code],
            registrant: payload[:registrant],
            period_unit: payload[:period_unit],
            period: payload[:period],
            admin_contact: payload[:admin_contact], # Array of idents
            tech_contact: payload[:tech_contact], # Array of idents
            nameserver_attributes: payload[:nameserver_attributes].each do |ns_attr|
              {
              hostname: ns_attr[:hostname],
              ipv4: ns_attr[:ipv4],
              ipv6: ns_attr[:ipv6],
              }
              end,
            dnskey_attributes: payload[:dnskey_attributes].each do |dnskey_attr|
              {
              flags: dnskey_attr[:flags],
              protocol: dnskey_attr[:protocol],
              alg: dnskey_attr[:alg],
              public_key: dnskey_attr[:public_key],
              }
              end,
          }
        }
      end
    end
  end
end
