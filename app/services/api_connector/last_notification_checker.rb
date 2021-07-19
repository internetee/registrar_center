# frozen_string_literal: true

class ApiConnector
  class LastNotificationChecker < ApiConnector
    ACTION = 'check_notification'

    def check_notification
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
