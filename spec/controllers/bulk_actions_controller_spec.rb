require 'rails_helper'

RSpec.describe BulkActionsController, type: :controller do
  options = [
    {
      method: :domain_transfer,
      http_method: :post,
      params: {
        domain_transfers: [
          [{
             domain_name: "shop.test",
             transfer_code: 'aaabbbccc'
           }]
        ]
      }
    },
    {
      method: :contact_replace,
      http_method: :patch,
      params: {
        current_contact_id: 1,
        new_contact_id: 2
      }
    },
    {
      method: :nameserver_change,
      http_method: :put,
      params: {
        nameserver_id: 1,
        domains: ['shop.test, airport.test'],
        nameserver_attributes: {
          hostname: "ns1.#{Faker::Internet.domain_name}",
          ipv4: Faker::Internet.ip_v4_address,
          ipv6: Faker::Internet.ip_v6_address
        }
      }
    },
  ]

  it_behaves_like "Base controller with auth", options
end