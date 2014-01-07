class Post < ActiveRecord::Base
  # These post are based on a user
  belongs_to :user
  # Each post has commments, delete them when the post is deleted
  has_many :comments, dependent: :destroy
  # Make the post order in desc order
  default_scope -> { order('created_at DESC') }
  # Require there to be content
  validates :user_id, presence: true
  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 25 }
  validates :content, presence: true
  validates :is_visible, inclusion: [true, false]
  validates :is_mail_sent, inclusion: [true, false]
  # Picture attachments and resizing
  has_attached_file :thumbnail, :styles => { :original => "600x300#" }, :default_url => "600x300.gif"
  validates :thumbnail, attachment_presence: true
  has_attached_file :header, :styles => { :original => "900x300#" }, :default_url => "900x300.gif"
  validates :header, attachment_presence: true

  # Vanity Url
  def to_param
    "#{slug}"
  end
end