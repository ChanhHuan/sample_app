class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page]
    return if current_user? @user
    @follow = current_user.active_relationships.find_by followed_id: @user.id
    return if @follow
    @follow = current_user.active_relationships.build
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "check"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "delete"
      redirect_to users_path
    else
      flash[:danger] = t "undelete"
      redirect_to root_path
    end
  end

  def following
    @title = t "following"
    @users = @user.following.paginate page: params[:page]
    render :show_follow
  end

  def followers
    @title = t "followers"
    @users = @user.followers.paginate page: params[:page]
    render :show_follow
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "error"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
