module ClockOperation
  module SleepingRecordQueries
    class FriendRecords
      def initialize(friend_id:)
        @friend_id = friend_id
      end

      def all
        relation
      end

      private
      def relation
        ClockOperation::SleepingRecord.where(
          user_id: @friend_id
        ).finished.order('count_time_in_bed DESC NULLS LAST', updated_at: :desc)
      end
    end
  end
end
