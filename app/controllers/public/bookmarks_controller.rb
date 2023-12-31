class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!
  def create
    post = Post.find(params[:post_id])
    @bookmark = current_user.bookmarks.new(post_id: post.id)
    @bookmark.save
  end

  def destroy
    post = Post.find(params[:post_id])
    @bookmark = current_user.bookmarks.find_by(post_id: post.id)
    @bookmark.destroy
  end

  def index
    user = current_user
    bookmark = Bookmark.where(user_id: user.id).order(created_at: :desc).pluck(:post_id)
    @bookmarks = Post.where(id: bookmark).page(params[:page]).per(5)
  end
end
