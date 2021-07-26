# frozen_string_literal: true

class ApiConnector
  class NotificationReadMarker < ApiConnector
    ACTION = 'mark_notification_read'
    DEFAULT_PARAMS = {
      notification: {
        read: true,
      },
    }.freeze

    def mark_notification_read(id: 0)
      request(url: url_with_id(id), method: method, params: DEFAULT_PARAMS)
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
