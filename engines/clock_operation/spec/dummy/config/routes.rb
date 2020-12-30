Rails.application.routes.draw do
  mount ClockOperation::Engine => "/clock_operation"
end
