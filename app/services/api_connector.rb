# frozen_string_literal: true

class ApiConnector
  attr_reader :auth_token

  def initialize(username:, password:)
    @auth_token = generate_token(username: username, password: password)
  end

  private

  def generate_token(username:, password:)
    Base64.urlsafe_encode64("#{username}:#{password}")
  end
end
