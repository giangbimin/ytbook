class SessionsController < ApplicationController
  def create
    service = RegistrationOrLoginService.new(login_params[:email], login_params[:password])
    login_process = service.execute
    if login_process[:status]
      session[:user_id] = login_process[:user_id]
      flash.now[:success] = "Login Success."
      redirect_to root_path
    else
      flash.now[:alert] = login_process[:error]
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    def login_params
      params.require(:session).permit(:email, :password)
    end
end