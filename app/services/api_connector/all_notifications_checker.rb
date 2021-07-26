# frozen_string_literal: true

class ApiConnector
  class AllNotificationsChecker < ApiConnector
    ACTION = 'check_all_notifications'
    DEFAULT_LIMIT = 200
    DEFAULT_OFFSET = 0
    DEFAULT_PARAMS = {
      limit: DEFAULT_LIMIT,
      offset: DEFAULT_OFFSET,
    }.freeze

    def check_all_notifications(limit: DEFAULT_LIMIT, offset: DEFAULT_OFFSET)
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
