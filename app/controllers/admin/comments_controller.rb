class Admin::CommentsController < ApplicationController
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end
end
