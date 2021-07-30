# frozen_string_literal: true

class ApiConnector
  module Contacts
    class All < ApiConnector
      include EndpointRequestable
      ACTION = 'load_all_contacts'
      ENDPOINT = {
        method: 'get',
        endpoint: '/contacts',
      }.freeze

      def load_all_contacts
        request(url: endpoint_url, method: method)
      end
    end
  end
end
