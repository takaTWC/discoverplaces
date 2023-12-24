class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @users = User.all
    @comments = Comment.all
    @contacts = Contact.all
  end
end
