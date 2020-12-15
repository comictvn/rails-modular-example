module Identity
  class Engine < ::Rails::Engine
    isolate_namespace Identity

    initializer "indentity.middleware" do |app|
      app.config.middleware.use ActionDispatch::Cookies
      app.config.middleware.use ActionDispatch::Session::CookieStore  
    end
  end
end
