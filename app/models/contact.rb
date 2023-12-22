class Contact < ApplicationRecord
  belongs_to :user, optional: true
  
  validates :title, presence: true
  validates :contact, presence: true
end