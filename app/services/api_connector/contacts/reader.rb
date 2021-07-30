# frozen_string_literal: true

class ApiConnector
  module Contacts
    class Reader < ApiConnector
      include EndpointRequestable
      ACTION = 'read_contact'
      ENDPOINT = {
        method: 'get',
        endpoint: '/contacts',
      }.freeze

      def read_contact(id: 0)
        request(url: url_with_id(id), method: method)
      end
    end
  end
end
