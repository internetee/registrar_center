# frozen_string_literal: true

class DnssecsController < BaseController
  # Get all the nameservers for domain name
  def show
    conn = ApiConnector::Dnssec::All.new(**auth_info)
    cmd = conn.load_all_dnssec_keys(domain_name: dnssec_params[:domain_name])

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def new; end

  # Add new nameserver to the domain
  def create
    conn = ApiConnector::Dnssec::Creator.new(**auth_info)
    cmd = conn.create_dnssec_keys(domain_name: dnssec_params[:domain_name],
                                  payload: dnssec_payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def destroy
    conn = ApiConnector::Dnssec::Deleter.new(**auth_info)
    cmd = conn.delete_dnssec_keys(domain_name: dnssec_params[:domain_name],
                                  payload: dnssec_payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  private

  def dnssec_params
    params.permit(:domain_name, :nameserver_hostname, dns_keys: [%i[flags protocol alg public_key]])
  end

  def dnssec_payload
    { dns_keys: dnssec_params[:dns_keys] }
  end
end
