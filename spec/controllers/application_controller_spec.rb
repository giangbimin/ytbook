require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe "#current_user" do
    context "when session[:user_id] is present" do
    let(:user) { create(:user, email: "test@example.com", password: "password") }
      before do
        session[:user_id] = user.id
      end
      it "should set @user to the user with the given user_id" do
        controller.current_user
        expect(assigns(:user)).to eq(user)
      end
    end
    context "when session[:user_id] is nil" do
      before do
        session[:user_id] = nil
      end
      it "should not set @user" do
        controller.current_user
        expect(assigns(:user)).to be_nil
      end
    end
  end
  describe "#logged_in?" do
    context "when current_user is present" do
      let(:user) { create(:user, email: "test@example.com", password: "password") }
      before do
        allow(controller).to receive(:current_user).and_return(user)
      end
      
      it "should return true" do
        expect(controller.logged_in?).to be_truthy
      end
    end
    context "when current_user is nil" do
      before do
        allow(controller).to receive(:current_user).and_return(nil)
      end
      
      it "should return false" do
        expect(controller.logged_in?).to be_falsey
      end
    end
  end
end