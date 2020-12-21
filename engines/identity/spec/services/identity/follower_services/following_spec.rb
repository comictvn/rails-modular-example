require 'rails_helper'
RSpec.describe ::Identity::FollowerServices::Following do
  let(:requester) { create(:user) }
  let(:addressee) { create(:user, name: Faker::Name.name, email: 'kevin@gmail.com') }

  subject(:following_opts) { described_class.new(addressee_id: addressee.id, current_user: requester) }

  describe '#call' do
    context 'when valid following' do
      it 'returns a record' do
        opts = following_opts.call
        expect(opts).to have_attributes(addressee_id: addressee.id, requester_id: requester.id)
      end

      it 'has new user_follow record' do
        following_opts.call
        expect(Identity::UserFollow.count).to eq 1
      end

      it 'has user_follow record is matched' do
        following_opts.call
        user_follow = Identity::UserFollow.where(addressee_id: addressee.id, requester_id: requester.id)
        expect(user_follow.count).to eq 1
      end
    end

    context 'when invalid following' do
      it 'raises a follower already taken' do
        following_opts.call
        expect { following_opts.call }
          .to raise_error(Identity::FollowerServices::FollowingInvalid, /The addressee have already been taken/)
      end
    end
  end
end
