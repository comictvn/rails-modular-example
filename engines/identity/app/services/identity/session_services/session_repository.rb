module Identity
  module SessionServices
    class SessionRepositoryInvalid < StandardError; end
    class SessionRepository
      def initialize(email, password)
        @email = email
        @password = password
      end

      def call
        return raise(
          SessionRepositoryInvalid, I18n.t('identity.session.invalid_credentials')
        ) if construct_session.nil?
        Identity::JwtService.encode(payload)
      end

      private
      def construct_session
        @construct_session ||= begin
          user = Identity::User.find_by(email: @email)
          user if user && user.authenticate(@password)
        end
      end

      def payload
        {
          user_id: construct_session.id,
          email: construct_session.email,
          name: construct_session.name
        }
      end
    end
  end
end
