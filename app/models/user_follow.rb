class UserFollow < ApplicationRecord
  validates_presence_of :requester_id, :addressee_id

  belongs_to :addressee, foreign_key: 'addressee_id', class_name: User.name
  belongs_to :requester, foreign_key: 'requester_id', class_name: User.name
end
