require 'rails_helper'
RSpec.describe ::Identity::FollowerServices::Unfollowing do
  let(:requester) { create(:user) }
  let(:addressee) { create(:user, name: Faker::Name.name, email: 'kevin@gmail.com') }

  subject(:following_opts) { Identity::FollowerServices::Following.new(addressee_id: addressee.id, current_user: requester) }
  subject(:unfollowing_opts) { described_class.new(addressee_id: addressee.id, current_user: requester) }

  describe '#call' do
    context 'when valid unfollowing' do
      it 'has user_follow record is deleted' do
        following_opts.call
        unfollowing_opts.call
        expect(Identity::UserFollow.count).to eq 0
      end

      it 'has user_follow record is matched' do
        following_opts.call
        unfollowing_opts.call
        user_follow = Identity::UserFollow.where(addressee_id: addressee.id, requester_id: requester.id)
        expect(user_follow.count).to eq 0
      end
    end

    context 'when invalid following' do
      it 'raises a follower already taken' do
        following_opts.call
        unfollowing_opts.call
        expect { unfollowing_opts.call }
          .to raise_error(Identity::FollowerServices::UnfollowingInvalid, /The addressee isn't exists/)
      end
    end
  end
end
