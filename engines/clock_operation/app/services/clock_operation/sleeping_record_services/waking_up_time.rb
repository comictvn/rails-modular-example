module ClockOperation
  module SleepingRecordServices
    class WakingUpTimeInvalid < StandardError; end
    class WakingUpTime
      def initialize(user_id:, sleeping_record_id:, waking_up_time: Time.current)
        @user_id = user_id
        @waking_up_time = waking_up_time
        @sleeping_record_id = sleeping_record_id
      end

      def call
        raise(
          SleepingRecordServices::WakingUpTimeInvalid, 
          I18n.t('clock_operation.sleeping_record.without_record_beding_time')
        ) unless tracking_record_inprogess?
        
        tracking_record.clock_out = @waking_up_time
        tracking_record.count_time_in_bed = calculate_beding_time
        tracking_record.save!
        tracking_record
      end

      private
      def tracking_record
        @tracking_record ||= ClockOperation::SleepingRecord.find_by(
          user_id: @user_id,
          id: @sleeping_record_id
        )
      end

      def calculate_beding_time
        (@waking_up_time - tracking_record.clock_in).to_i
      end

      def tracking_record_inprogess?
        ClockOperation::SleepingRecord.where(
          user_id: @user_id
        ).where('clock_out IS NULL').order(created_at: :desc).exists?
      end
    end
  end
end
