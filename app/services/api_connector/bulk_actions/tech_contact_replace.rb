# frozen_string_literal: true

class ApiConnector
  module BulkActions
    class TechContactReplace < ApiConnector
      include EndpointRequestable
      ACTION = 'replace_contacts'
      ENDPOINT = {
        method: 'patch',
        endpoint: '/domains/contacts',
      }.freeze

      def replace_contacts(payload: nil)
        request(url: endpoint_url, method: method, params: transfer_params(payload))
      end

      private

      def transfer_params(payload)
        {
          current_contact_id: payload[:current_contact_id],
          new_contact_id: payload[:new_contact_id],
        }
      end
    end
  end
end
