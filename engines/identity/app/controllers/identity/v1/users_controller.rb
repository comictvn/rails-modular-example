module Identity
  module V1
    class UsersController < BaseController
      def index
        page_number = (params[:page] || 1).to_i
        users = User.order(created_at: :desc)
                          .paginate(page: page_number)

        options = {}
        options[:meta] = { pager: { 
          total: users.total_entries, 
          current: page_number, 
          per_page: User.per_page } 
        }
        json_records = Identity::V1::UserSerializer.new(users, options).serializable_hash
        json_response(json_records)
      end

      private
      def follower_params
        params.permit(:addressee_id)
      end
    end
  end
end
