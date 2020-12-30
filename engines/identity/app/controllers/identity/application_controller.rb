module Identity
  class ApplicationController < ActionController::API
    include ::Shared::ResponseSerializer
    include ::Shared::ExceptionHandler
    include ::Shared::AuthProtection
  end
end
