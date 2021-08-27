class SessionsController < ApplicationController
  def new; end

  def create
    conn = AuthChecker.new(username: auth_params['username'], password: auth_params['password'])
    res = conn.check_auth
    session[:uuid] = res.uuid if res.authenticated

    # TODO: render smth based on res.authenticated
  end

  def auth_params
    params.permit(:login, :password)
  end
end
