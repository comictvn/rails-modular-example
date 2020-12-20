module Identity
  module FollowerServices
    class UnfollowingInvalid < StandardError; end
    class Unfollowing
      def initialize(addressee_id:, current_user: User.current_user)
        @current_user = current_user
        @addressee_id = addressee_id
      end

      def call
        raise(
          FollowerServices::UnfollowingInvalid, I18n.t('identity.followers.not_exists')
        ) unless UserFollow.where(requester_id: @current_user.id, addressee_id: @addressee_id).exists?
        @current_user.requesters.where(addressee_id: @addressee_id).delete_all
      end
    end
  end
end
