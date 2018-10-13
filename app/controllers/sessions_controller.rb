class SessionsController < ApplicationController

  def new;end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = t "message_account_not_active"
        message += t "message_notice_check_email"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "flash_danger_invalid_pass"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
