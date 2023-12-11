class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user = current_user
    tag_list = params[:post][:name].split(',')
    if post.save
      post.save_tags(tag_list)
      redirect_to post_path(post)
    else
      render :new
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
    @posts = Post.all
    @tag_list = Tag.all
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :image)
  end
end
