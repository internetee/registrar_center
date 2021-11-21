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
  ]

  it_behaves_like "Base controller with auth", options
end