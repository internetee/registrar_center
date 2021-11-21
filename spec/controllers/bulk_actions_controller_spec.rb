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
  ]

  it_behaves_like "Base controller with auth", options
end