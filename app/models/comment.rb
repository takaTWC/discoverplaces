class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :score_high_count, -> {order(score: :desc)}
  scope :score_low_count, -> {order(score: :asc)}
end
