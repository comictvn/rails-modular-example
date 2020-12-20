module ClockOperation
  class ApplicationController < ActionController::API
    include ResponseSerializer
    include ExceptionHandler
    include AuthProtection
  end
end
