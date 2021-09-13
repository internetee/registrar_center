class SessionsController < ApplicationController
  def new; end

  def create
    conn = AuthChecker.new(**store_hash)
    res = conn.check_auth

    if res.authenticated
      session[:uuid] = res.uuid
      cache.write(res.uuid, store_hash )
      render text: 'ok', status: :ok
    else
      render :new, status: :forbidden
    end
  end

  def auth_params
    params.permit(:username, :password)
  end

  def cache
    Rails.cache
  end

  def store_hash
    {
      username: auth_params['username'],
      password: auth_params['password'],
    }
  end
end
