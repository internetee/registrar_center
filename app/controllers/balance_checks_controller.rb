class BalanceChecksController < BaseController
  # Get balance
  def show
    conn = ApiConnector::BalanceChecker.new(**auth_info)
    res = conn.check_balance(**conn_attrs)

    if res.success
      @messages = res.body['data']
    elsif res.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  private

  def balance_params
    params.permit(:detailed, :from, :until)
  end

  def detailed
    ActiveModel::Type::Boolean.new.cast(balance_params[:detailed])
  end

  def conn_attrs
    {
      detailed: detailed,
      from: balance_params[:from],
      until: balance_params[:until],
    }
  end
end
