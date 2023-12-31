class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def new
    @post = Post.new
    @post.build_place
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    # Unicodeで半角スペース、全角スペースを指定
    tag_list = params[:post][:name].split(/\s|\u3000/)
    # 位置情報のパラメータ
    address = params[:post][:place_attributes][:address]
    latitude = params[:post][:place_attributes][:latitude]
    longitude = params[:post][:place_attributes][:longitude]
    Post.transaction do
      if @post.save
        @post.save_tags(tag_list)
        @post.save_with_place(address, latitude, longitude)
        redirect_to post_path(@post)
      else
        render :new
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
    @tags = @post.tags
    @comment = Comment.new
    @post.view_count_for_user(current_user)
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.page(params[:page]).per(5)
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :image, :latitude, :longitude)
  end
end