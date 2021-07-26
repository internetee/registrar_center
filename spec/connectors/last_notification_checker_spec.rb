require 'rails_helper'

RSpec.describe ApiConnector::LastNotificationChecker do
  it_behaves_like "Token generator"

  context 'without any params' do
    options = {
      request_params: nil,
      check_with_params: false,
    }

    it_behaves_like 'Request sender', options
  end
end
