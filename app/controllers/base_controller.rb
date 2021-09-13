class BaseController < ApplicationController

  before_action :check_auth_info

  def check_auth_info
    redirect_to controller: 'sessions', action: 'new' unless auth_info_present?
  end

  private

  def auth_info_present?
    auth_info[:username].present? && auth_info[:password].present?
  end

  def auth_info
    uuid = session[:uuid]
    Rails.cache.fetch(uuid).with_indifferent_access
  end
end
