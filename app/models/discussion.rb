class Discussion < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy

  scope :sorted, ->{ order(updated_at: :desc)}
  
  validates :title, presence: true

  accepts_nested_attributes_for :posts
  
end
