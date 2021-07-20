require 'rails_helper'

RSpec.describe 'ApiConnector' do
  it 'generates auth token' do
    username = Faker::Lorem.word
    password = Faker::Internet.password
    token = Base64.urlsafe_encode64("#{username}:#{password}")
    conn = ApiConnector.new(username: username, password: password)
    expect(conn.auth_token).to eq token
  end
end
