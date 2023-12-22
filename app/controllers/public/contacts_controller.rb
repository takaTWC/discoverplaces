class Public::ContactsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if user_signed_in?
      @contact.user = current_user
    end
    if @contact.save
      flash[:notice] = "お問い合わせが完了しました。"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def index
    @user = current_user
    @contacts = @user.contacts.page(params[:page]).per(5)
  end

  private
  def contact_params
    params.require(:contact).permit(:title, :contact, :email, :name)
  end
end
