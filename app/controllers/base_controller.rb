class BaseController < ApplicationController
  before_action :check_auth_info

  def check_auth_info
    redirect_to controller: 'sessions', action: 'new' unless auth_info_present?
  end

  private

  def auth_info_present?
    return false unless auth_info.is_a?(Hash)

    auth_info[:username]&.present? && auth_info[:password]&.present?
  end

  def auth_info
    uuid = session[:uuid]
    Rails.cache.fetch(uuid)&.symbolize_keys
  end

  def internal_server_error
    render status: :internal_server_error
  end
end
