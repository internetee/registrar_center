RSpec.shared_examples "Base controller with auth" do |options|
  let(:uuid) { Faker::Internet.uuid }
  let(:username) { Faker::Lorem.word }
  let(:password) { Faker::Internet.password }
  let(:auth_data)  { { username: username, password: password } }

  options.each do |option|
    it "successfully checks for auth info in session" do
      session[:uuid] = uuid
      Rails.cache.write(uuid, auth_data)
      VCR.use_cassette("#{described_class}-#{option[:method]}") do
        self.send(option[:http_method], option[:method], params: option[:params])
      end

      expect(response.status).to eq(200)
    end

    it "Redirects if no uuid in session" do
      session[:uuid] = nil
      self.send(option[:http_method], option[:method], params: option[:params])

      expect(response.status).to eq(302)
    end

    it "Redirects if no auth data stored" do
      session[:uuid] = uuid
      self.send(option[:http_method], option[:method], params: option[:params])

      expect(response.status).to eq(302)
    end
  end
end
