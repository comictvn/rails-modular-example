module Identity
  module V1
    class LogoutController < BaseController
      def create
        cookies.delete :jwt
        json_response({})
      end
    end
  end
end
