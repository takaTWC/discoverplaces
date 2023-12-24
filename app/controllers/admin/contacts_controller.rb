class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @contacts = Contact.page(params[:page]).per(10)
  end

  def show
    @contact = Contact.find(params[:id])
    @user = @contact.user
  end

  def update
    contact = Contact.find(params[:id])
    contact.update(contact_params)
    redirect_to admin_contact_path(contact)
  end

  private
  def contact_params
    params.require(:contact).permit(:title, :contact, :email, :name, :reply, :support)
  end
end
