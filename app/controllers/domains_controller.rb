# frozen_string_literal: true

class DomainsController < BaseController
  def index
    conn = ApiConnector::Domains::All.new(**auth_info)
    cmd = conn.load_all_domains

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def show
    conn = ApiConnector::Domains::Reader.new(**auth_info)
    cmd = conn.read_domain(domain_name: domain_params[:id])

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
    conn = ApiConnector::Domains::Creator.new(**auth_info)
    cmd = conn.create_domain(payload: create_payload)

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
    conn = ApiConnector::Domains::Updater.new(**auth_info)
    cmd = conn.update_domain(domain_name: domain_params[:domain_name], payload: update_payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def renew
    conn = ApiConnector::Domains::Renewer.new(**auth_info)
    cmd = conn.renew_domain(domain_name: domain_params[:domain_name], payload: renew_payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def destroy
    conn = ApiConnector::Domains::Deleter.new(**auth_info)
    cmd = conn.delete_domain(domain_name: domain_params[:domain_name], payload: domain_payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def add_hold
    conn = ApiConnector::Statuses::Adder.new(**auth_info)
    cmd = conn.add_client_hold(domain_name: domain_params[:domain_name])

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def remove_hold
    conn = ApiConnector::Statuses::Remover.new(**auth_info)
    cmd = conn.remove_client_hold(domain_name: domain_params[:domain_name])

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  private

  def domain_params
    params.permit(:id, :verified, :auth_code, :domain_name, :name, :reserved_pw, :transfer_code,
                  :period_unit, :period, :admin_contact, :tech_contact,
                  :registrant, :code, :verified,
                  nameserver_attributes: [[:hostname, :ipv4, :ipv6]],
                  dnskey_attributes: [[:flags, :protocol, :alg, :public_key]])
  end

  def domain_payload
    {
      verified: domain_params[:verified],
      auth_code: domain_params[:auth_code],
    }
  end

  def create_payload
    {
      name: domain_params[:name],
      reserved_pw: domain_params[:reserved_pw],
      transfer_code: domain_params[:transfer_code],
      registrant: domain_params[:registrant],
      period_unit: domain_params[:period_unit],
      period: domain_params[:period],
      admin_contact: domain_params[:admin_contact], # Array of idents
      tech_contact: domain_params[:tech_contact], # Array of idents
      nameserver_attributes: domain_params[:nameserver_attributes].map do |ns_attr| # Array
        {
          hostname: ns_attr[:hostname],
          ipv4: ns_attr[:ipv4],
          ipv6: ns_attr[:ipv6],
        }
      end,
      dnskey_attributes: domain_params[:dnskey_attributes].map do |dnskey_attr| # Array
        {
          flags: dnskey_attr[:flags],
          protocol: dnskey_attr[:protocol],
          alg: dnskey_attr[:alg],
          public_key: dnskey_attr[:public_key],
        }
      end,
    }
  end

  def update_payload
    {
      registrant: {
        code: domain_params[:code],
        verified: domain_params[:verified],
      },
      transfer_code: domain_params[:transfer_code],
    }
  end

  def renew_payload
    {
      period: domain_params[:period],
      period_unit: domain_params[:period_unit],
      exp_date: domain_params[:exp_date],
    }
  end
end
