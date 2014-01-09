class Download < ActiveRecord::Base
  # Content
  validates :title, presence: true
  validates :content, presence: true
  validates :weight_id, presence: true, numericality: { only_integer: true }
  # Booleans
  validates :is_public, inclusion: [true, false]
  validates :is_private, inclusion: [true, false]
end
