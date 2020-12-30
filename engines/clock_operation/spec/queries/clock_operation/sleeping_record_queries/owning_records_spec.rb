require 'rails_helper'
RSpec.describe ::ClockOperation::SleepingRecordQueries::OwningRecords do
  let(:user) { create(:user, email: 'kevin@gmail.com') }
  let(:sleeping_record) {
    create_list(:sleeping_record, 
      5,
      clock_in: Time.current, 
      clock_out: Time.current + 1.hours,
      user_id: user.id)
  }

  describe '#call' do
    context 'when valid select own records' do
      subject(:own_records_opts) do
        described_class.new(user_id: user.id)
      end

      it 'returns list sleeping records which belong to me' do
        sleeping_record
        records = own_records_opts.all
        expect(records.size).to eq(5)
      end
    end

    context 'when select sleeping records still in-progress' do
      let(:sleeping_record) {
        create_list(:sleeping_record, 
          5,
          clock_in: Time.current, 
          clock_out: Time.current + 1.hours,
          user_id: user.id)
      }

      let(:in_progress_sleeping_record) {
        create_list(:sleeping_record, 
          5,
          clock_in: Time.current,
          user_id: user.id)
      }

      subject(:own_records_opts) do
        described_class.new(user_id: user.id)
      end

      it 'returns sleeping records without the records in-progress' do
        sleeping_record
        in_progress_sleeping_record

        records = own_records_opts.all
        expect(records.size).to eq(5)
      end
    end
  end
end
