# frozen_string_literal: true

class ApiConnector
  module Contacts
    class Deleter < ApiConnector
      include EndpointRequestable
      ACTION = 'delete_contact'

      def delete_contact(id: 0)
        request(url: url_with_id(id), method: method)
      end
    end
  end
end
