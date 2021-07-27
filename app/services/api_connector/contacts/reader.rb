# frozen_string_literal: true

class ApiConnector
  module Contacts
    class Reader < ApiConnector
      ACTION = 'read_contact'

      def read_contact(id: 0)
        request(url: url_with_id(id), method: method)
      end

      private

      def url_with_id(id)
        "#{endpoint_url}/#{id}"
      end

      def endpoint_url
        endpoint(ACTION)
      end

      def method
        request_method(ACTION)
      end
    end
  end
end
