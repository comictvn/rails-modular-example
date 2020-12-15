module Identity
  module V1
    class MeController < BaseController
      def index
        user_jsons = Identity::V1::MeSerializer.new(current_user).serializable_hash
        json_response(user_jsons)
      end
    end
  end
end
