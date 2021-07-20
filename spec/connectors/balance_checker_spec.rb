require 'rails_helper'

RSpec.describe ApiConnector::BalanceChecker do
  it_behaves_like "Token generator", ApiConnector::BalanceChecker

  it 'can check balance' do
    pending 'Network stub isn`t implemented yet'
    except(conn.check_balance).to be_a Hash
  end
end
