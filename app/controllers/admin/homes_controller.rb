class Admin::HomesController < ApplicationController
  def top
    @users = User.all
    @comments = Comment.all
  end
end
