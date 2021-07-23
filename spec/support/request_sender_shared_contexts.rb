def request_method(klass)
  endpoints[klass::ACTION.to_sym][:method]
end

def base_url
  "#{ENV['REPP_HOST']}#{ENV['REPP_ENDPOINT']}"
end

def endpoints
  ApiConnector::EndpointsStorage::ENDPOINTS
end

def request_url(klass)
  base_url + endpoints[klass::ACTION.to_sym][:endpoint]
end

RSpec.shared_context "Request sender" do |options|
  klass= options[:klass]
  args = {
      url: request_url(klass),
      method: request_method(klass),
      params: options[:params],
    }
  result = { code: 1000 }

  before do
    allow_any_instance_of(klass).to receive(:request).with(args).and_return(result)
  end
end
