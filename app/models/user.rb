class User < ApplicationRecord
  has_secure_password

  validates :nickname, :email, presence: true, uniqueness: true
end
