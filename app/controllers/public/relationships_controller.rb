class Public::RelationshipsController < ApplicationController
  def create
    @user = current_user
    @user.follow(params[:user_id])
  end

  def destroy
    @user = current_user
    @user.unfollow(params[:user_id])
  end
end
