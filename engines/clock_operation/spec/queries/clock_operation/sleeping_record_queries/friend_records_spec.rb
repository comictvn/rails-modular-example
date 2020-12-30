require 'rails_helper'
RSpec.describe ::ClockOperation::SleepingRecordQueries::FriendRecords do
  let(:friend) { create(:user, email: 'kevin@gmail.com') }
  let(:sleeping_record) {
    create_list(:sleeping_record, 
      5,
      clock_in: Time.current, 
      clock_out: Time.current + 1.hours,
      user_id: friend.id)
  }

  describe '#call' do
    context 'when valid select friend records' do
      subject(:friend_records_opts) do
        described_class.new(friend_id: friend.id)
      end

      it 'returns list sleeping records which belong to a friend' do
        sleeping_record
        records = friend_records_opts.all
        expect(records.size).to eq(5)
      end
    end

    context 'when select sleeping records with invalid friend' do
      subject(:friend_records_opts) do
        described_class.new(friend_id: 3)
      end

      it 'returns no sleeping records' do
        sleeping_record
        records = friend_records_opts.all
        expect(records.size).to eq(0)
      end
    end

    context 'when select sleeping records still in-progress' do
      let(:sleeping_record) {
        create_list(:sleeping_record, 
          5,
          clock_in: Time.current, 
          clock_out: Time.current + 1.hours,
          user_id: friend.id)
      }

      let(:in_progress_sleeping_record) {
        create_list(:sleeping_record, 
          5,
          clock_in: Time.current,
          user_id: friend.id)
      }

      subject(:friend_records_opts) do
        described_class.new(friend_id: friend.id)
      end

      it 'returns sleeping records without the records in-progress' do
        sleeping_record
        in_progress_sleeping_record

        records = friend_records_opts.all
        expect(records.size).to eq(5)
      end
    end
  end
end
