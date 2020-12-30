module ClockOperation
  class User < ApplicationRecord
    self.table_name = 'users'
    
    has_many :sleeping_records, dependent: :delete_all
  end
end
