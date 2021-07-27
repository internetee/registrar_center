# frozen_string_literal: true

class ApiConnector
  module Contacts
    class Updater < ApiConnector
      include EndpointRequestable
      ACTION = 'update_contact'

      def update_contact(payload: nil, id: 0)
        request(url: url_with_id(id), method: method, params: contact_params(payload))
      end

      private

      def contact_params(payload)
        {
          contact: {
            name: payload[:name],
            email: payload[:email],
            phone: payload[:phone],
          },
        }
      end
    end
  end
end
