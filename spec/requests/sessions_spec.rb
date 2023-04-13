require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user, email: "test@example.com", password: "password") }
  let(:valid_params) { { session: { email: user.email, password: user.password } } }
  describe "POST /login" do
    before do
      allow_any_instance_of(RegistrationOrLoginService).to receive(:execute).and_return({ status: true, user_id: user.id })
    end
    it "returns http success" do
      post "/login", params: valid_params
    end
  end

  describe "DELETE /logout" do
    it "returns http success" do
      delete "/logout"
    end
  end

end
