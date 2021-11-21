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

  end

  def nameserver_change

  end

  def domain_renew

  end

  private

  def bulk_actions_params
    params.permit(domain_transfers: [[:domain_name, :transfer_code]])
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
end
