class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  # Username
  validates(:username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 5, maximum: 20 })
  # Email subscriptions
  validates :is_subscribed, inclusion: [true, false]
end
