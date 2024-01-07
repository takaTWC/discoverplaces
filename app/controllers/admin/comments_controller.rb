class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:latest]
      base_query = Comment.latest
    elsif params[:old]
      base_query = Comment.old
    elsif params[:score_high_count]
      base_query = Comment.score_high_count
    elsif params[:score_low_count]
      base_query = Comment.score_low_count
    else
      base_query = Comment.all
    end
    @comments = base_query.page(params[:page]).per(10)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end
end
