module Identity
  class JwtServiceInvalid < StandardError; end
  class JwtServicePayloadEmpty < StandardError; end
  class JwtService
    HMAC_SECRET = ENV['JWT_PRIVATE_KEY']
    EXPIRED = 90.days.from_now.freeze

    WARN_EXCEPTIONS = [
      JWT::DecodeError,
      JWT::ExpiredSignature,
      JWT::ImmatureSignature,
      JWT::VerificationError,
      JwtServiceInvalid
    ]

    def self.encode(payload, verify_key = HMAC_SECRET, exp = EXPIRED)
      raise(JwtServicePayloadEmpty) if payload.blank?
      payload[:exp] = exp.to_i
      JWT.encode(payload, verify_key)
    end

    def self.decode(token, verify_key = HMAC_SECRET)
      body = JWT.decode(token, verify_key)[0]
      HashWithIndifferentAccess.new body
    end
  end
end
