class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.page(params[:page]).per(10)
  end

  def disable
    @user = User.find(params[:id])
    if @user.update(is_active: false)
      flash[:notice] = "強制退会させました"
      redirect_to admin_user_path(@user)
    else
      render :show
    end
  end

  def enable
    @user = User.find(params[:id])
    if @user.update(is_active: true)
      flash[:notice] = "アカウントを有効化しました"
      redirect_to admin_user_path(@user)
    else
      render :show
    end
  end
end
