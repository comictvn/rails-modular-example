class JwtServiceInvalid < StandardError; end
class JwtService
  HMAC_SECRET = ENV['JWT_PRIVATE_KEY']
  EXPIRED = 90.days.from_now.freeze

  WARN_EXCEPTIONS = [
    ::JWT::DecodeError,
    ::JWT::ExpiredSignature,
    ::JWT::ImmatureSignature,
    ::JWT::VerificationError,
    JwtServiceInvalid
  ]

  def self.encode(payload, exp = EXPIRED)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
  rescue *WARN_EXCEPTIONS => error
    raise JsonWebTokenInvalid, e.message
  end
end
