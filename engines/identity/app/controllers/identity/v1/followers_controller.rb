module Identity
  module V1
    class FollowersController < BaseController
      def index
        page_number = (params[:page] || 1).to_i
        friend_lists = UserFollow.includes(:addressee)
          .where(requester_id: current_user.id)
          .order(created_at: :desc)
          .paginate(page: page_number)

        options = {}
        options[:meta] = { pager: { 
          total: friend_lists.total_entries, 
          current: page_number, 
          per_page: UserFollow.per_page } 
        }
        json_records = Identity::V1::FollowerSerializer.new(friend_lists, options).serializable_hash
        json_response(json_records)
      end

      def create
        Identity::FollowerServices::Following.new(
          addressee_id: follower_params[:addressee_id],
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
      def follower_params
        params.permit(:addressee_id)
      end
    end
  end
end
