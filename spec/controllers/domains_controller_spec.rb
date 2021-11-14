require 'rails_helper'

RSpec.describe DomainsController, type: :controller do
  options = [
    {
      method: :index,
      http_method: :get,
    },
    {
      method: :show,
      http_method: :get,
      params: {
        domain_name: Faker::Internet.domain_name,
      }
    },
    {
      method: :destroy,
      http_method: :delete,
      params: {
        domain_name: 'aaa.bbb',
        payload: {
          verified: true,
          auth_code: Faker::Crypto.md5,
        }
      },
    },
    {
      method: :update,
      http_method: :put,
      params: {
        domain_name: 'test.test',
        registrant: {
          code: Faker::Lorem.word,
          verified: true,
        },
        transfer_code: Faker::Crypto.md5,
      }
    },
    {
      method: :create,
      http_method: :post,
      params: {
        name: Faker::Internet.domain_name,
        reserved_pw: Faker::Internet.password,
        transfer_code: Faker::Internet.password,
        registrant: Faker::Lorem.word,
        period_unit: %w[m y].sample,
        period: Faker::Number.positive(from: 1, to: 5),
        admin_contact: [Faker::Lorem.word],
        tech_contact: [Faker::Lorem.word],
        nameserver_attributes: [{
                                  hostname: "ns1.#{Faker::Internet.domain_name}",
                                  ipv4: Faker::Internet.ip_v4_address,
                                  ipv6: Faker::Internet.ip_v6_address
                                }],
        dnskey_attributes: [{
                              flags: [256, 257].sample,
                              protocol: 3,
                              alg: [3,5,6,7,8,10,13,14].sample,
                              public_key: Faker::Crypto.sha256,
                            }],
      }
    },
    {
      method: :renew,
      http_method: :put,
      params: {
        domain_name: 'test.test',
        period: Faker::Number.positive(from: 1, to: 5),
        period_unit: %w(y m).sample,
        exp_date: Date.today,
      }
    },
    {
      method: :remove_hold,
      http_method: :delete,
      params: {
        domain_name: 'aaa.bbb',
      },
    },
    {
      method: :add_hold,
      http_method: :put,
      params: {
        domain_name: 'test.test',
      },
    }
  ]

  it_behaves_like "Base controller with auth", options
end
