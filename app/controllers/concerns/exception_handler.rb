module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class InvalidToken < StandardError; end
  
  included do
    # Define custom handlers
    rescue_from AuthenticationError, with: :unauthorized_request
    rescue_from InvalidToken, with: :unauthorized_request
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def render_422(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end

  def record_errors(e)
    json_response({ message: e.record.errors.full_messages }, :unprocessable_entity)
  end
end
