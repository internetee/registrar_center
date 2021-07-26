def klass
  described_class
end

def endpoints
  ApiConnector::EndpointsStorage::ENDPOINTS
end

def request_url
  base_url + endpoints[checking_method][:endpoint]
end

def base_url
  "#{ENV['REPP_HOST']}#{ENV['REPP_ENDPOINT']}"
end

def request_method
  endpoints[checking_method][:method]
end

def checking_method
  described_class::ACTION.to_sym
end

def result
  { code: 1000 }
end

def stub_args(options)
  params = options[:request_params]
  result = params.present? ? args.merge(params: params) : args
  result[:url] += options[:add_to_url].to_s
  result
end

def args
  {
    url: request_url,
    method: request_method,
  }
end

def new_class_attrs
  {
    username: Faker::Lorem.word,
    password: Faker::Lorem.word
  }
end

def stub_params(options)
  {
    params: options[:request_params],
    url: options[:url]
  }
end

RSpec.shared_examples "Request sender" do |options|
  it 'sends request' do
    method_params = options[:method_params]
    check_with_params = options[:check_with_params]

    expect_any_instance_of(described_class).to receive(:request).with(stub_args(options)).and_return(result)

    conn = described_class.new(**new_class_attrs)
    check_with_params ? conn.send(checking_method, **method_params) : conn.send(checking_method)
  end
end
