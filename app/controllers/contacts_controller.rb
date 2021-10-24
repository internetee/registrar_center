# frozen_string_literal: true

class ContactsController < BaseController

  # Get all the contacts
  def index
    conn = ApiConnector::Contacts::All.new(**auth_info)
    cmd = conn.load_all_contacts

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  # Show the contact info
  def show
    conn = ApiConnector::Contacts::Reader.new(**auth_info)
    cmd = conn.read_contact(id: contact_params[:id])

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def destroy
    conn = ApiConnector::Contacts::Deleter.new(**auth_info)
    cmd = conn.delete_contact(id: contact_params[:id])

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def new; end

  def create

  end

  private

  def contact_params
    params.permit(:id)
  end

end
