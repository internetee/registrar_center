# frozen_string_literal: true

class ApiConnector
  module Contacts
    class All < ApiConnector
      ACTION = 'load_all_contacts'

      def load_all_contacts
        request(url: endpoint_url, method: method)
      end

      private

      def endpoint_url
        endpoint(ACTION)
      end

      def method
        request_method(ACTION)
      end
    end
  end
end
