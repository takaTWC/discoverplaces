class Public::HomesController < ApplicationController
  def top
    @post_favorite_ranks = Post.post_favorite_ranks
    @post_view_count_ranks = Post.post_view_counts_ranks
  end
end
