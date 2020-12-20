module Identity
  module FollowerServices
    class FollowingInvalid < StandardError; end
    class Following
      def initialize(addressee_id:, current_user: User.current_user)
        @current_user = current_user
        @addressee_id = addressee_id
      end

      def call
        raise(
          FollowerServices::FollowingInvalid, I18n.t('identity.followers.already_taken')
        ) if UserFollow.where(requester_id: @current_user.id, addressee_id: @addressee_id).exists?
        @current_user.requesters.create!(addressee_id: @addressee_id)
      end
    end
  end
end
