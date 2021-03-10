class Blog < ApplicationRecord
  include Impressionist::IsImpressionable
  is_impressionable

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  
  
  belongs_to :user
  has_many :elements
  
  has_one_attached :header_image
  
  validates_presence_of :title, :description
  validates_length_of :description, within: 50..250
  
  scope :published, -> do
    where(published: true)
  end

  scope :most_recently_published, -> do
    order(published_at: :desc)
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

  def self.impressionist
    Impression.where(impressionable_type: "Blog")
  end
end
