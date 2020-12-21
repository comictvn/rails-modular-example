require 'email_validator'

module Identity
  class User < ApplicationRecord
    self.table_name = 'users'
    
    has_secure_password
    cattr_accessor :current_user
    validates :email, presence: true, email: true, uniqueness: { case_sensitive: true }
    validates_presence_of :name, :password_digest
    validates :email, presence: true, uniqueness: { case_sensitive: true }

    has_many :requesters, foreign_key: 'requester_id', dependent: :delete_all, class_name: UserFollow.name
    has_many :addressees, foreign_key: 'addressee_id', dependent: :delete_all, class_name: UserFollow.name
  end
end
