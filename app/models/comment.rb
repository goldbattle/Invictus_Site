class Comment < ActiveRecord::Base
  # These post are based on a post
  belongs_to :post
  # These post are based on a user
  belongs_to :user
  # Make the post order in desc order
  default_scope -> { order('created_at ASC') }
  # Require there to be content
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 400 }
end
