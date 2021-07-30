# frozen_string_literal: true

class ApiConnector
  module BulkActions
    class DomainTransfer < ApiConnector
      include EndpointRequestable
      ACTION = 'create_transfer'
      ENDPOINT = {
        method: 'post',
        endpoint: '/domains/transfer',
      }.freeze

      def create_transfer(payload: nil)
        request(url: endpoint_url, method: method, params: transfer_params(payload))
      end

      private

      def transfer_params(payload)
        {
          data: {
            domain_transfers: payload[:domain_transfers].map do |transfer|
              {
                domain_name: transfer[:domain_name],
                transfer_code: transfer[:transfer_code]
              }
            end,
          },
        }
      end
    end
  end
end
