class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = post.id
    @comment.save
  end

  def destroy
    post = Post.find(params[:post_id])
    @comment = current_user.comments.find_by(params[:id])
    @comment.post_id = post.id
    @comment.destroy
  end

  def index
    user = current_user
    @comments = user.comments
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
