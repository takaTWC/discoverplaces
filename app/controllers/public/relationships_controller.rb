class Public::RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user.id)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user.id)
  end
end
