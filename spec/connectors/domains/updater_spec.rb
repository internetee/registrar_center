require 'rails_helper'

RSpec.describe ApiConnector::Domains::Updater do
  it_behaves_like "Token generator"

  payload = {
    registrant: {
      code: Faker::Lorem.word,
      verified: [true, false].sample,
    },
    transfer_code: Faker::Crypto.md5,
  }
  domain_name = Faker::Internet.domain_name

  options = {
    request_params: { domain: payload },
    method_params: { payload: payload, domain_name: domain_name },
    check_with_params: true,
    add_to_url: "/#{domain_name}",
  }

  context 'with parameter' do
    it_behaves_like 'Request sender', options
  end
end
