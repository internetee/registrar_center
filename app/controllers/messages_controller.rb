class MessagesController < BaseController
  # Get all the messages
  def index
    conn = ApiConnector::AllNotificationsChecker.new(**auth_info)
    res = conn.check_all_notifications(limit: messages_params[:limit],
                                       offset: messages_params[:offset])

    if res.success
      @messages = res.body['data']
    elsif res.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  # Get a specific message
  def show; end

  # Get latest unread message
  def latest; end

  # Mark message as read
  def edit; end

  def update; end

  private

  def messages_params
    params.permit(:limit, :offset)
  end
end
