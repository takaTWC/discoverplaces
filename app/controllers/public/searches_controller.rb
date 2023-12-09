class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @posts = Post.looks(params[:word])
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts
  end
end
