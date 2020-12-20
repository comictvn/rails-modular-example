module ClockOperation
  module V1
    class SleepingRecordSerializer
      include FastJsonapi::ObjectSerializer

      attributes :id, :clock_in, :clock_out, :count_time_in_bed
    end
  end
end
