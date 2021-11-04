require 'rails_helper'

RSpec.describe NameserversController, type: :controller do
  options = [
    {
      method: :show,
      http_method: :get,
      params: {
        domain_name: 'library.test',
      }
    },
    {
      method: :create,
      http_method: :post,
      params: {
        domain_name: 'library.test',
        nameservers: [{
                        hostname: "ns1.library.test",
                        ipv4: Faker::Internet.ip_v4_address,
                        ipv6: Faker::Internet.ip_v6_address
                      }]
      }
    },
    {
      method: :destroy,
      http_method: :delete,
      params: {
        domain_name: 'library.test',
        nameserver_hostname: 'ns1.aaa.test'
      },
    },

  ]

  it_behaves_like "Base controller with auth", options
end
