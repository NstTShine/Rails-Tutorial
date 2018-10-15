class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new;end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "flash_info_email_sent"
      redirect_to root_url
    else
      flash.now[:danger] = t "flash_danger_email_not_found"
      render :new
    end
  end

  def edit;end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, (t "errors_password_empty"))
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      @user.update_attribute :reset_digest, nil
      flash[:success] = t "flash_password_has_been_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  # Before filters

  def get_user
    @user = User.find_by email: params[:email]

    return if @user
    flash[:danger] = t "user_not_found"
    redirect_to root_url
  end

  # Confirms a valid user.
  def valid_user
    return if @user && @user.activated? &&
      @user.authenticated?(:reset, params[:id])
    redirect_to root_url
  end

  # Checks expiration of reset token
  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "flash_password_reset_expired"
    redirect_to new_password_reset_url
  end
end
