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
      mark_notification_read: {
        method: 'put',
        endpoint: '/registrar/notifications',
      },
      read_notification: {
        method: 'get',
        endpoint: '/registrar/notifications',
      },
      load_all_contacts: {
        method: 'get',
        endpoint: '/contacts',
      },
      read_contact: {
        method: 'get',
        endpoint: '/contacts',
      },
      delete_contact: {
        method: 'delete',
        endpoint: '/contacts',
      },
      create_contact: {
        method: 'post',
        endpoint: '/contacts',
      },
      update_contact: {
        method: 'put',
        endpoint: '/contacts',
      },
    }.freeze
  end
end
