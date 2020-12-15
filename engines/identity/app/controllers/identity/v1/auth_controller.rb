module Identity
  module V1
    class AuthController < BaseController
      skip_before_action :authorize_request, only: :create
      
      def create
        token = ::Identity::SessionServices::SessionRepository.new(
          auth_params[:email], auth_params[:password]
        ).()
        set_cookie_jwt(token)
        json_response({})
      end

      private
      def auth_params
        params.permit(:email, :password)
      end

      def set_cookie_jwt(token)
        cookies[:jwt] = {
          value: token,
          httponly: true
        }
      end
    end
  end
end
