require 'rails_helper'

module ClockOperation
  RSpec.describe SleepingRecord, type: :model do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:clock_in) }
    it { should belong_to(:user).class_name('User') }
  end
end
