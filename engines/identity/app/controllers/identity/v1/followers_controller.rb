module Identity
  module V1
    class FollowersController < BaseController
      def create
        Identity::FollowerServices::Following.new(
          addressee_id: auth_params[:addressee_id],
          current_user: current_user
        ).()
        json_response({})
      end

      def destroy
        Identity::FollowerServices::Unfollowing.new(
          addressee_id: params[:id],
          current_user: current_user
        ).()
        json_response({})
      end

      private
      def auth_params
        params.permit(:addressee_id)
      end
    end
  end
end
