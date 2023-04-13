require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_params) {
    {email: "test@example.com", password: "123456"}
  }

  let(:invalid_params) {
    {email: "test", password: "1456"}
  }

  describe "GET #new" do
    it "assigns a new user as @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user" do
        expect {
          post :create, params: { user: valid_params }
        }.to change(User, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { user: valid_params }
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash message" do
        post :create, params: { user: valid_params }
        expect(flash[:notice]).to eq("User was successfully created.")
      end
    end

    context "with invalid params" do
      it "does not create a new user" do
        expect {
          post :create, params: { user:invalid_params }
        }.not_to change(User, :count)
      end

      it "renders the :new template" do
        post :create, params: { user: invalid_params }
        expect(response).to render_template(:new)
      end
    end
  end
end