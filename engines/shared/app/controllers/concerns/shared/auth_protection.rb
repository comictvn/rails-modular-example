module Shared
  module AuthProtection
    extend ActiveSupport::Concern

    included do
      before_action :authorize_request
    end

    attr_reader :current_user

    private
    def authorize_request
      if user_session.blank?
        raise(
          ExceptionHandler::InvalidToken, I18n.t('authentication.invalid_token')
        )
      end
      @current_user = user_session
    end

    def user_session
      user_session_by_jwt
    end

    def user_session_by_jwt
      return unless jwt_user_id.present?
      ::Shared::User.find_by(id: jwt_user_id)
    end

    def jwt_user_id
      request.env['jwt.sleeping_user_id']
    end
  end
end
