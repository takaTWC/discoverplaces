class FollowRelation < ApplicationRecord
  belongs_to :user
  belongs_to :follow
end
