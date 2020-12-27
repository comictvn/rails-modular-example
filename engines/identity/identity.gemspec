$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "identity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "identity"
  spec.version     = Identity::VERSION
  spec.authors     = ["Kevin"]
  spec.email       = ["comictvn@gmail.com"]
  spec.homepage    = "https://github.com/comictvn"
  spec.summary     = "Summary of Identity."
  spec.description = "Description of Identity."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.4"
  spec.add_dependency "rspec-rails"
  spec.add_dependency "rack-cors"
  spec.add_dependency "sqlite3"
  spec.add_dependency "factory_bot_rails"
  spec.add_dependency "bcrypt"
  spec.add_dependency "email_validator"
  spec.add_dependency 'pg', '>= 0.18', '< 2.0'
  spec.add_dependency 'jwt'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'dotenv-rails'
end
