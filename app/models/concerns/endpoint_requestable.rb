module EndpointRequestable
  extend ActiveSupport::Concern
  included do
    private

    def url_with_id(id)
      "#{endpoint_url}/#{id}"
    end

    def endpoint_url
      endpoint(self.class::ENDPOINT)
    end

    def method
      request_method(self.class::ENDPOINT)
    end
  end
end
