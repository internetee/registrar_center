RSpec.shared_examples "Auth checker" do |options|
  let(:uuid) { Faker::Internet.uuid }
  let(:username) { Faker::Lorem.word }
  let(:password) { Faker::Internet.password }
  let(:auth_data)  { { username: username, password: password } }

  it "successfully checks for auth info in session" do
    session[:uuid] = uuid
    Rails.cache.write(uuid, auth_data)
    VCR.use_cassette("#{described_class}-#{options[:method]}") do
      get options[:method]
    end

    expect(response.status).to eq(200)
  end

  it "Redirects if no uuid in session" do
    session[:uuid] = nil
    get options[:method]

    expect(response.status).to eq(302)
  end

  it "Redirects if no auth data stored" do
    session[:uuid] = uuid
    get options[:method]

    expect(response.status).to eq(302)
  end
end
