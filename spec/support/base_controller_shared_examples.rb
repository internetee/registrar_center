RSpec.shared_examples "Base controller with auth" do |options|
  let(:uuid) { Faker::Internet.uuid }
  let(:username) { 'test_bestnames' }
  let(:username_fail) { Faker::Lorem.word }
  let(:password) { 'testtest' }
  let(:password_fail) { Faker::Internet.password }
  let(:auth_data_legal)  { { username: username, password: password } }
  let(:auth_data_fail)  { { username: username_fail, password: password_fail } }

  options.each do |option|
    it "successfully checks for auth info in session" do
      session[:uuid] = uuid
      Rails.cache.write(uuid, auth_data_legal)
      VCR.use_cassette("#{described_class}-#{option[:method]}") do
        self.send(option[:http_method], option[:method], params: option[:params])
      end

      expect([200, 302]).to  include (response.status)
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

    it "Redirects to auth controller if failed auth" do
      session[:uuid] = uuid
      Rails.cache.write(uuid, auth_data_fail)

      VCR.use_cassette("#{described_class}-#{option[:method]}-auth-fail") do
        self.send(option[:http_method], option[:method], params: option[:params])
      end

      expect(response).to redirect_to(controller: 'sessions', action: 'new')
    end
  end
end
