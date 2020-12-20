module ClockOperation
  module SleepingRecordQueries
    class OwningRecords
      def initialize(user_id:)
        @user_id = user_id
      end

      def all
        relation
      end

      private
      def relation
        ClockOperation::SleepingRecord.where(
          user_id: @user_id
        ).order(updated_at: :desc)
      end
    end
  end
end
