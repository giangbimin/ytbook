require 'rails_helper'

RSpec.describe "/users", type: :request do
  let(:valid_attributes) {
    {email: "test@example.com", password: "123456"}
  }

  let(:invalid_attributes) {
    {email: "test", password: "1456"}
  }

  describe "GET /register" do
    it "renders a successful response" do
      get register_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post users_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the root" do
        post users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post users_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post users_url, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
