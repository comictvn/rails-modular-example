# frozen_string_literal: true
module Middleware
  class JWT
    def initialize(app)
      @app = app
    end

    def call(env)
      request_cookies = Rack::Utils.parse_cookies(env)
      return call_next(env) unless request_cookies.present?
      jwt_token = request_cookies['jwt']
      return call_next(env) unless jwt_token.present?
      set_env_variables(jwt_token, env)
      call_next(env)
    end

    private

    def call_next(env)
      @app.call(env)
    end

    def request_with_cookies(env)
      request = Rack::Request.new(env)
      cookies = request.env['action_dispatch.cookies']
      cookies['jwt']
    end

    def set_env_variables(token, env)
      jwt = ::JwtService.decode(token)
      env['jwt.sleeping_user_id'] = jwt['user_id']
    end
  end
end
