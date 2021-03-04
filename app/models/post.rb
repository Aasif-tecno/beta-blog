class Post < ApplicationRecord
  belongs_to :discussion
  belongs_to :user
  has_rich_text :body
  
  scope :sorted, ->{ order(created_at: :asc)}
end
