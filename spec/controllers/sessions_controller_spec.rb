require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    let(:user) { create(:user, email: "test@example.com", password: "password") }
    let(:valid_params) { { session: { email: user.email, password: user.password } } }

    context "with valid credentials" do
      it "logs in the user" do
        allow_any_instance_of(RegistrationOrLoginService).to receive(:execute).and_return({ status: true, user_id: user.id })
        post :create, params: valid_params
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to the root page" do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end

      it "sets a success flash message" do
        post :create, params: valid_params
        expect(flash[:success]).to eq("Login Success.")
      end
    end

    context "with invalid credentials" do
      let(:invalid_params) {{ session: { email: "invalid", password: "password" } }}
      let(:error_response) {{ status: false, error: "Email or password is invalid"}}

      it "does not log in the user" do
        allow_any_instance_of(RegistrationOrLoginService).to receive(:execute).and_return(error_response)
        post :create, params: invalid_params
        expect(session[:user_id]).to be_nil
      end

      it "sets an alert flash message" do
        allow_any_instance_of(RegistrationOrLoginService).to receive(:execute).and_return(error_response)
        post :create, params: invalid_params
        expect(flash[:alert]).to eq(error_response[:error])
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:user) { create(:user, email: "test@example.com", password: "password") }

    before do
      session[:user_id] = user.id
    end

    it "logs out the user" do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root page" do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end