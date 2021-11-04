# frozen_string_literal: true

class NameserversController < BaseController
  # Get all the nameservers for domain name
  def show
    conn = ApiConnector::Nameservers::All.new(**auth_info)
    cmd = conn.load_all_nameservers(domain_name: nameserver_params[:domain_name])

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
    conn = ApiConnector::Nameservers::Creator.new(**auth_info)
    cmd = conn.create_nameservers(domain_name: nameserver_params[:domain_name],
                                  payload: new_nameserver_payload)

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  def destroy
    conn = ApiConnector::Nameservers::Deleter.new(**auth_info)
    cmd = conn.delete_nameserver(domain_name:  nameserver_params[:domain_name],
                                 nameserver_hostname: nameserver_params[:nameserver_hostname])

    if cmd.success
      @messages = cmd.body['data']
    elsif cmd.body['code'] == 2202
      redirect_to controller: 'sessions', action: 'new'
    else
      internal_server_error
    end
  end

  private

  def nameserver_params
    params.permit(:domain_name, :nameserver_hostname, nameservers: [[:hostname, :ipv4, :ipv6]])
  end

  def new_nameserver_payload
    {
      nameservers: nameserver_params[:nameservers]
    }
  end
end
