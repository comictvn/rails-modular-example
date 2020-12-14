module SessionServices
  class SessionRepositoryInvalid < StandardError;
  class SessionRepository
    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      return unless construct_session.present?
      JsonWebToken.encode(payload)
    end

    private
    def construct_session
      user = Identify::User.find_by(email: email)
      return if user && user.authenticate(password)
      raise(SessionRepositoryInvalid, I18n.t('authentication.invalid_credentials'))
    end
  end
end
