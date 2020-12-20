module ClockOperation
  module V1
    class SleepingRecordsController < BaseController
      def index
        page_number = (params[:page] || 1).to_i
        records = ClockOperation::SleepingRecordQueries::OwningRecords.new(
          user_id: current_user.id
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

      def create
        record = ClockOperation::SleepingRecordServices::RecordingBedingTime.new(
          user_id: current_user.id
        ).()
        record_json = ClockOperation::V1::SleepingRecordSerializer.new(record).serializable_hash
        json_response(record_json)
      end

      def update
        record = ClockOperation::SleepingRecordServices::WakingUpTime.new(
          user_id: current_user.id,
          sleeping_record_id: params[:id]
        ).()
        record_json = ClockOperation::V1::SleepingRecordSerializer.new(record).serializable_hash
        json_response(record_json)
      end
    end
  end
end
