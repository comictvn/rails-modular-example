class User < ApplicationRecord
  has_secure_password
  cattr_accessor :current_user

  validates_presence_of :name, :password_digest
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: true }
end
