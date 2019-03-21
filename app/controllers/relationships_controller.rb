class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_followed_id, only: :create
  before_action :load_relationship, only: :destroy

  def create
    current_user.follow @user
    respond_to do |format|
      @follow = current_user.active_relationships.find_by(
        followed_id: @user.id
      )
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = @relationship.followed
    if @user
      current_user.unfollow @user
      respond_to do |format|
        @follow = current_user.active_relationships.build
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "delete_followed"
      redirect_to current_user
    end
  end

  private

  def load_followed_id
    @user = User.find_by id: params[:followed_id]
    return if @user
    flash[:danger] = t "error"
    redirect_to root_path
  end

  def load_relationship
    @relationship = Relationship.find_by id: params[:id]
    return if @relationship
    flash[:danger] = t "error"
    redirect_to root_path
  end
end
