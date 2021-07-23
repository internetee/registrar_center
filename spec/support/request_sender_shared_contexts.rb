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

def prepare_creation_params
  let(:new_attrs) {
    {
      username: Faker::Lorem.word,
      password: Faker::Lorem.word
    }
  }
end

def prepare_method_params(params)
  let(:method_params) { params }
end

def options(params)
  {
    klass: described_class,
    params: params,
  }
end

def check_sending_request(method:, params: {})
  prepare_creation_params
  prepare_method_params(params)
  it 'can send requests' do
    conn = described_class.new(**new_attrs)
    conn.send(method, **method_params)
  end
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
