class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @post.build_place
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    tag_list = params[:post][:name].split(',')
    Post.transaction do
      if @post.save
        @post.save_tags(tag_list)
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
    @posts = Post.page(params[:page]).per(5)
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :image, :latitude, :longitude, place_attributes: [:address, :latitude, :longitude])
  end
end
