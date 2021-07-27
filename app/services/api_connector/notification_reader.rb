# frozen_string_literal: true

class ApiConnector
  class NotificationReader < ApiConnector
    ACTION = 'read_notification'

    def read_notification(id: 0)
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
