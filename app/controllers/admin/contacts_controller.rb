class Admin::ContactsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @contacts = Contact.page(params[:page]).per(10)
  end

  def show
    @contact = Contact.find(params[:id])
    @user = @contact.user
  end
end
