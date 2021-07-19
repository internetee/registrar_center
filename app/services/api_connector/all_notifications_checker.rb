# frozen_string_literal: true

class ApiConnector
  class AllNotificationsChecker < ApiConnector
    ACTION = 'check_all_notifications'

    def check_all_notifications(limit: 200, offset: 0)
      params = {
        limit: limit,
        offset: offset,
      }
      request(url: endpoint_url, params: params, method: method)
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
