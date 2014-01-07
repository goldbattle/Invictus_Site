class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  # Username
  validates(:username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 5, maximum: 20 })
  # Email subscriptions
  validates :is_subscribed, inclusion: [true, false]
  # User roles
  ROLES = %w[admin moderator registered banned]

  # Upgrading from a legacy account
  def valid_password?(password)
    if self.respond_to?('legacy_password_hash') && self.legacy_password_hash.present?
      if BCrypt::Password.new(self.legacy_password_hash) == password
        self.password = password
        self.legacy_password_hash = nil
        self.save!
        true
      else
        false
      end
    else
      super
    end
  end

  # Upgrading from a legacy account
  def reset_password!(*args)
    self.legacy_password_hash = nil
    super
  end
end
