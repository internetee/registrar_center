# frozen_string_literal: true

class ApiConnector
  class NotificationReadMarker < ApiConnector
    ACTION = 'mark_notification_read'

    def mark_notification_read(id)
      params = {
        notification: {
          read: true,
        },
      }
      request(url: url_with_id(id), method: method, params: params)
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
