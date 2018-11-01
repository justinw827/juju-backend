class User < ApplicationRecord
  has_many :user_groups
  has_many :groups, through: :user_groups

  has_many :events, through: :groups

  # Returns true if access_token is older than 55 minutes
  def is_token_expired?
    (Time.now - self.updated_at) > 3300
  end
end
