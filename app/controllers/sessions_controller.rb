class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def new; end

  def create
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        remember_user
        redirect_back_or @user
      else
        flash[:warning] = t "check_link"
        redirect_to root_url
      end
<<<<<<< HEAD
=======
      redirect_back_or @user
>>>>>>> 5b8b7102c63a892c1b05b36a3cff094d3ddd728c
    else
      flash.now[:danger] = t "error1"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user
    flash.now[:danger] = t "error"
    render :new
  end

  def remember_user
    if params[:session][:remember_me] == Settings.remember
      remember(@user)
    else
      forget(@user)
    end
  end
end
