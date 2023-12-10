class Public::WatchListsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    watch_list = current_user.watch_lists.new(post_id: post.id)
    watch_list.save
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    watch_list = current_user.watch_lists.find_by(post_id: post.id)
    watch_list.destroy
    redirect_to request.referer
  end
end
