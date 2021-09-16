require 'rails_helper'

RSpec.describe BalanceChecksController, type: :controller do
  options = [
    {
      method: :show,
      http_method: :get,
      params: {
        detailed: false,
        from: Time.zone.today - 10.days,
        until: Time.zone.today - 5.days
      },
    },
  ]

  it_behaves_like "Base controller with auth", options

end
