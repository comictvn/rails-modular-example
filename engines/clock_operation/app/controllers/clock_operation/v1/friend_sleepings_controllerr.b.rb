module ClockOperation
  module V1
    class FriendSleepingsController < BaseController
      def index
        page_number = (params[:page] || 1).to_i
        records = ClockOperation::SleepingRecordQueries::FriendRecords.new(
          friend_id: params[:friend_id],
        ).all.paginate(page: page_number)
        options = {}
        options[:meta] = { pager: { 
          total: records.total_entries, 
          current: page_number, 
          per_page: ClockOperation::SleepingRecord.per_page } 
        }
        json_records = ClockOperation::V1::SleepingRecordSerializer.new(records, options).serializable_hash
        json_response(json_records)
      end
    end
  end
end
