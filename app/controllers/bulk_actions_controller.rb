# frozen_string_literal: true

class BulkActionsController < BaseController
  def domain_transfer
    conn = ApiConnector::BulkActions::DomainTransfer.new(**auth_info)
    cmd = conn.create_transfer(payload: transfer_payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def contact_replace
    conn = ApiConnector::BulkActions::TechContactReplace.new(**auth_info)
    cmd = conn.replace_contacts(payload: replace_contact_payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def nameserver_change
    conn = ApiConnector::BulkActions::NameserverChange.new(**auth_info)
    cmd = conn.replace_nameserver(payload: replace_nameserver_payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def domain_renew
    conn = ApiConnector::BulkActions::DomainRenew.new(**auth_info)
    cmd = conn.renew(payload: domain_renew_payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  private

  def bulk_actions_params
    params.permit(:current_contact_id, :new_contact_id, :nameserver_id, :domains, :renew_period,
                  domain_transfers: [[:domain_name, :transfer_code]],
                  nameserver_attributes: [:hostname, :ipv4, :ipv6])
  end

  def transfer_payload
    {

      domain_transfers: bulk_actions_params[:domain_transfers].map do |transfer|
        {
          domain_name: transfer[:domain_name],
          transfer_code: transfer[:transfer_code],
        }
      end,
    }
  end

  def replace_contact_payload
    {
      current_contact_id: bulk_actions_params[:current_contact_id],
      new_contact_id: bulk_actions_params[:new_contact_id],
    }
  end

  def replace_nameserver_payload
    {
      id: bulk_actions_params[:nameserver_id],
      domains: bulk_actions_params[:domains],
      attributes: {
        hostname: bulk_actions_params[:nameserver_attributes][:hostname],
        ipv4: bulk_actions_params[:nameserver_attributes][:ipv4],
        ipv6: bulk_actions_params[:nameserver_attributes][:ipv6],
      },
    }
  end

  def domain_renew_payload
    {
      domains: bulk_actions_params[:domains],
      renew_period: bulk_actions_params[:renew_period],
    }
  end
end
