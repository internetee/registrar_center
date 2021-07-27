# frozen_string_literal: true

class ApiConnector
  module Contacts
    class Deleter < ApiConnector
      ACTION = 'delete_contact'

      def delete_contact
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
