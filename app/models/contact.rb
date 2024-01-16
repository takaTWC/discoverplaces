class Contact < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, presence: true
  validates :contact, presence: true

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

  def reply_status
    reply.present?
  end
end
