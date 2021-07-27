# frozen_string_literal: true

class ApiConnector
  module Contacts
    class All < ApiConnector
      include EndpointRequestable
      ACTION = 'load_all_contacts'

      def load_all_contacts
        request(url: endpoint_url, method: method)
      end
    end
  end
end
