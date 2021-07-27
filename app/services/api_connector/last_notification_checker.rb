# frozen_string_literal: true

class ApiConnector
  class LastNotificationChecker < ApiConnector
    include EndpointRequestable
    ACTION = 'check_notification'

    def check_notification
      request(url: endpoint_url, method: method)
    end
  end
end
