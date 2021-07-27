# frozen_string_literal: true

class ApiConnector
  module Contacts
    class Creator < ApiConnector
      include EndpointRequestable
      ACTION = 'create_contact'

      def create_contact(payload: nil)
        request(url: endpoint_url, method: method, params: contact_params(payload))
      end

      private

      def contact_params(payload)
        {
          contact: {
            name: payload[:name],
            email: payload[:email],
            phone: payload[:phone],
            ident: {
              ident: payload[:ident][:ident],
              ident_type: payload[:ident][:ident_type],
              ident_country_code: payload[:ident][:ident_country_code],
            },
          }
        }
      end
    end
  end
end
