class CreateClockOperationSleepingRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :clock_operation_sleeping_records do |t|
      t.integer :user_id, index: true
      t.datetime :clock_in
      t.datetime :clock_out
      t.integer :count_time_in_bed
      t.timestamps
    end
  end
end
