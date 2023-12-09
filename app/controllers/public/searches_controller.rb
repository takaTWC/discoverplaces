class Public::SearchesController < ApplicationController
  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts
  end
end
