module Identity
  module V1
    class BaseController < ApplicationController
      include ActionController::Cookies
    end
  end
end
