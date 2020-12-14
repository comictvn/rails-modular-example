class JsonWebToken
  HMAC_SECRET = Rails.application.credentials.secret_key_base
  EXPIRED = 90.days.from_now.freeze

  def self.encode(payload, exp = EXPIRED)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
