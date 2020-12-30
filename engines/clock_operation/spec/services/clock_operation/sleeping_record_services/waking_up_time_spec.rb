require 'rails_helper'
RSpec.describe ::ClockOperation::SleepingRecordServices::WakingUpTime do
  let(:user) { create(:user) }
  let(:time_current) { Time.current }
  let(:waking_up_time) { Time.current + 1.hours }
  let(:sleeping_record) { create(:sleeping_record, clock_in: time_current, user_id: user.id) }

  describe '#call' do
    context 'when valid input waking time' do
      subject(:waking_up_time_opts) do
        described_class.new(
          user_id: user.id, 
          sleeping_record_id: sleeping_record.id, 
          waking_up_time: waking_up_time,
        )
      end

      it 'returns a sleeping record is matched' do
        opts = waking_up_time_opts.call
        expect(opts).to have_attributes(
          clock_in: time_current,
          user_id: user.id,
          clock_out: waking_up_time
        )
      end

      it 'calculate count time in bed' do
        opts = waking_up_time_opts.call
        expect(opts.count_time_in_bed).to eq((waking_up_time - time_current).to_i)
      end

      it 'check sleeping record is clocked out' do
        waking_up_time_opts.call
        sleeping_record.reload
        expect(sleeping_record.clock_out).not_to be_nil
      end
    end

    context 'when invalid input waking time' do
      subject(:waking_up_time_opts) do
        described_class.new(
          user_id: 9999, 
          sleeping_record_id: sleeping_record.id,
          waking_up_time: waking_up_time
        )
      end

      it 'raises an exception no exist tracking record' do
        expect { waking_up_time_opts.call }
          .to raise_error(::ClockOperation::SleepingRecordServices::WakingUpTimeInvalid, /There isn't beding record/)
      end
    end
  end
end
