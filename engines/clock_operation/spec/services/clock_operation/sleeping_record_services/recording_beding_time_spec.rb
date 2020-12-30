require 'rails_helper'
RSpec.describe ::ClockOperation::SleepingRecordServices::RecordingBedingTime do
  let(:user) { create(:user) }
  let(:beding_time) { Time.current + 1.hours }

  describe '#call' do
    context 'when valid input beding time' do
      subject(:recording_beding_time_opts) do
        described_class.new(
          user_id: user.id, 
          beding_time: beding_time,
        )
      end

      it 'returns a sleeping record with clock-in' do
        opts = recording_beding_time_opts.call
        expect(opts).to have_attributes(
          clock_in: beding_time,
          user_id: user.id,
          count_time_in_bed: nil,
          clock_out: nil
        )
      end

      it 'check a new sleeping record is created' do
        recording_beding_time_opts.call
        expect(ClockOperation::SleepingRecord.where(user_id: user.id).where('clock_out IS NULL').count).to eq 1
      end
    end

    context 'when invalid input beding time' do
      subject(:recording_beding_time_opts) do
        described_class.new(
          user_id: user.id, 
          beding_time: beding_time
        )
      end

      it 'raises an exception the record is in-progress' do
        recording_beding_time_opts.call
        expect { recording_beding_time_opts.call }
          .to raise_error(
            ::ClockOperation::SleepingRecordServices::RecordingBedingTimeInvliad, 
            /The record still ingporess/
          )
      end
    end
  end
end
