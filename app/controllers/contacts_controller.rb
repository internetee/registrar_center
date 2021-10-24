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
    conn = ApiConnector::Contacts::Creator.new(**auth_info)
    cmd = conn.create_contact(payload: payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def edit; end

  def update
    conn = ApiConnector::Contacts::Updater.new(**auth_info)
    cmd = conn.update_contact(id: contact_params[:id], payload: payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def check
    conn = ApiConnector::Contacts::AvailChecker.new(**auth_info)
    cmd = conn.check_contact(id: contact_params[:id])

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  private

  def contact_params
    params.permit(:id, :name, :email, :phone)
  end

  def payload
    {
      name: contact_params[:name],
      email: contact_params[:email],
      phone: contact_params[:phone],
      ident: {
        ident: contact_params[:ident],
        ident_type: contact_params[:ident_type],
        ident_country_code: contact_params[:ident_country_code],
      },
    }
  end
end
