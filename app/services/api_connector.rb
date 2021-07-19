# frozen_string_literal: true

class ApiConnector
  attr_reader :auth_token

  include ApiConnector::EndpointsStorage
  include ApiConnector::BalanceChecker

  def initialize(username:, password:)
    @auth_token = generate_token(username: username, password: password)
  end

  private

  def generate_token(username:, password:)
    Base64.urlsafe_encode64("#{username}:#{password}")
  end

  def base_url
    "#{ENV['REPP_HOST']}#{ENV['REPP_ENDPOINT']}"
  end

  def request(url:, params: {})
    Faraday.new(
      url: url,
      headers: { 'Authorization' => "Basic #{@auth_token}" },
      params: params
    )
  end

  def endpoint_url
    endpoint(ACTION)
  end

  def endpoint(action)
    base_url + ENDPOINTS[action.to_sym][:endpoint]
  end
end
