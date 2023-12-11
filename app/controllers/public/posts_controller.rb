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
      logger.debug @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
    @tags = @post.tags
    @comment = Comment.new
    unless ViewCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, post_id: @post.id)
      current_user.view_counts.create(post_id: @post.id)
    end
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
