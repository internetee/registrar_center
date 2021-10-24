require 'rails_helper'

RSpec.describe BalanceChecksController, type: :controller do
  options = [
    {
      method: :show,
      http_method: :get,
      params: {
        detailed: false,
        from: Date.new(2021,9,6),
        until: Date.new(2021,9,11)
      },
    },
  ]

  it_behaves_like "Base controller with auth", options

end
