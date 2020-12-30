module ClockOperation
  class SleepingRecord < ApplicationRecord
    validates_presence_of :user_id, :clock_in

    belongs_to :user

    scope :finished, -> { where('clock_in IS NOT NULL').where('clock_out IS NOT NULL') }
  end
end
