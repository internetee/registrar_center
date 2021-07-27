require 'rails_helper'

RSpec.describe ApiConnector::Contacts::All do
  it_behaves_like 'Token generator'

  options = {
    request_params: nil,
    check_with_params: false,
  }
  it_behaves_like 'Request sender', options
end
