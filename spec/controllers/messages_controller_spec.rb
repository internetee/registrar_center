require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  it_behaves_like "Auth checker", method: :index
end
