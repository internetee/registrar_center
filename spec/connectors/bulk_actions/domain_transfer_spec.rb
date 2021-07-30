require 'rails_helper'

RSpec.describe ApiConnector::BulkActions::DomainTransfer do
  it_behaves_like "Token generator"

  transfers = []
  3.times do
    transfers << {
      domain_name: Faker::Internet.domain_name,
      transfer_code: Faker::Crypto.md5,
    }
  end

  payload = {
    domain_transfers: transfers,
  }

  options = {
    request_params: { data: payload },
    method_params: { payload: payload },
    check_with_params: true
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
