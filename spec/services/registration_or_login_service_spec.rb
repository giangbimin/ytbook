require 'rails_helper'

RSpec.describe RegistrationOrLoginService, type: :service do
  describe "#execute" do
    let(:email) { "user@example.com" }
    let(:password) { "password" }
    let(:service) { RegistrationOrLoginService.new(email, password) }

    context "when user exists with valid credentials" do
      let!(:user) { create(:user, email: email, password: password) }

      it "returns status true and user id" do
        result = service.execute
        expect(result[:status]).to eq(true)
        expect(result[:user_id]).to eq(user.id)
      end
    end

    context "when user exists with invalid credentials" do
      let!(:user) { create(:user, email: email, password: "wrong_password") }

      it "returns error message" do
        result = service.execute
        expect(result[:status]).to eq(false)
        expect(result[:error]).to eq("Email or password is invalid")
      end
    end

    context "when user does not exist" do
      it "creates a new user and returns status true and user id" do
        result = service.execute
        expect(result[:status]).to eq(true)
        expect(result[:user_id]).not_to be_nil
      end
    end

    context "when user parameters are invalid" do
      let(:email) { "invalid_email" }
      let(:password) { "short" }

      it "returns error message" do
        result = service.execute
        expect(result[:status]).to eq(false)
        expect(result[:error]).to eq("Email or password is invalid")
      end
    end
  end
end