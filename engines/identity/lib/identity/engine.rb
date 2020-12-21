module Identity
  class Engine < ::Rails::Engine
    isolate_namespace Identity
    config.rspec_paths << self.root
    initializer "indentity.middleware" do |app|
      app.config.middleware.use ActionDispatch::Cookies
      app.config.middleware.use ActionDispatch::Session::CookieStore  
    end

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s+File::SEPARATOR
        app.config.paths["db/migrate"].concat(config.paths["db/migrate"].expanded)
      end
    end
  end
end
