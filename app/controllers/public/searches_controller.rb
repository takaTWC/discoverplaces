class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @posts = Post.page(params[:page]).per(5)
  end

  def search_tag
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page]).per(5)
  end

  def search_place
    @place = Place.find(params[:place_id])
    @posts = @place.posts.page(params[:page]).per(5)
  end
end
