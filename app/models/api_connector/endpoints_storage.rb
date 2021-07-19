# frozen_string_literal: true

# Data object to store endpoints/methods hash. Included into the ApiConnector service
class ApiConnector
  module EndpointsStorage
    ENDPOINTS = {
      check_balance: {
        method: 'get',
        endpoint: '/accounts/balance',
      },
      check_all_notifications: {
        method: 'get',
        endpoint: '/registrar/notifications/all_notifications',
      },
      check_notification: {
        method: 'get',
        endpoint: '/registrar/notifications',
      },
    }.freeze
  end
end
