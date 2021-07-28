# frozen_string_literal: true

class ApiConnector
  attr_reader :auth_token

  def initialize(username:, password:)
    @auth_token = generate_token(username: username, password: password)
  end

  private

  def request(url:, method:, params: nil)
    request = faraday_request(url: url, params: params)
    response = request.send(method)
    JSON.parse(response.body)
  end

  def generate_token(username:, password:)
    Base64.urlsafe_encode64("#{username}:#{password}")
  end

  def base_url
    "#{ENV['REPP_HOST']}#{ENV['REPP_ENDPOINT']}"
  end

  def faraday_request(url:, params: {})
    Faraday.new(
      url: url,
      headers: { 'Authorization' => "Basic #{@auth_token}" },
      params: params
    )
  end

  def endpoint(storage)
    base_url + storage[:endpoint]
  end

  def request_method(storage)
    storage[:method]
  end
end
