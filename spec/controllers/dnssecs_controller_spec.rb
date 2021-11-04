require 'rails_helper'

RSpec.describe DnssecsController, type: :controller do
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
        dns_keys: [{
                     flags: [256, 257].sample,
                     protocol: 3,
                     alg: [3,5,6,7,8,10,13,14].sample,
                     public_key: 'qwertyuiop',
                   }]
      }
    },
    {
      method: :destroy,
      http_method: :delete,
      params: {
        domain_name: 'library.test',
        dns_keys: [{
                     flags: [256, 257].sample,
                     protocol: 3,
                     alg: [3,5,6,7,8,10,13,14].sample,
                     public_key: 'qwertyuiop',
                   }]
      },
    },

  ]

  it_behaves_like "Base controller with auth", options
end
