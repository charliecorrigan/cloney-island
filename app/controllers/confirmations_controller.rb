class ConfirmationsController < ApplicationController
  # def new
  #   @user = current_user
  # end

  def create
    @user = current_user
    if @user.verification_code == params[:verification_code]
      session[:authenticated] = true
      flash[:notice] = "Verification code is correct!"
      redirect_to users_password_edit_path(current_user.id)
    else
      flash.now[:error] = "Verification code is incorrect."
      render :new
    end
  end

  def verify
    if User.exists?(email: params[:password][:email])
      user = User.find_by(email: params[:password][:email])
      ConfirmationSender.send_confirmation_to(user)
      redirect_to new_confirmation_path
    else
      flash.now[:error] = "Email address cannot be found."
      render :new
    end
  end
end
