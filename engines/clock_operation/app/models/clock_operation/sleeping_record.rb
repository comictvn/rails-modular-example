module ClockOperation
  class SleepingRecord < ApplicationRecord
    validates_presence_of :user_id, :clock_in

    belongs_to :user
  end
end
