module ClockOperation
  module SleepingRecordServices
    class RecordingBedingTimeInvliad < StandardError; end
    class RecordingBedingTime
      def initialize(user_id:, beding_time: Time.current)
        @user_id = user_id
        @beding_time = beding_time
      end

      def call
        raise(
          SleepingRecordServices::RecordingBedingTimeInvliad, 
          I18n.t('clock_operation.sleeping_record.inprogess_record')
        ) if tracking_record_inprogess?
        
        tracking_record.save!
        tracking_record
      end

      private
      def tracking_record
        @tracking_record ||= ClockOperation::SleepingRecord.new(
          user_id: @user_id,
          clock_in: @beding_time
        )
      end

      def tracking_record_inprogess?
        ClockOperation::SleepingRecord.where(
          user_id: @user_id
        ).where('clock_out IS NULL').order(created_at: :desc).exists?
      end
    end
  end
end
