class AuthChecker
  attr_reader :username, :password

  def initialize(username:, password:)
    @username = username
    @password = password
  end

  def check_auth
    connector = ApiConnector::LastNotificationChecker.new(username: @username, password: @password)

    result = connector.check_notification
    uuid = store_auth_info if result.success

    OpenStruct.new(**generate_response(result: result, uuid: uuid))
  end

  private

  def generate_response(result:, uuid:)
    {
      authenticated: result.success,
      code: result.body[:code],
      message: result.body[:message],
      uuid: uuid,
    }
  end

  def store_auth_info
    uuid = SecureRandom.uuid
    Rails.cache.write(uuid, { username: @username, password: @password })
    uuid
  end
end
