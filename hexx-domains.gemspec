$:.push File.expand_path("../lib", __FILE__)
require "hexx/domains/version"

Gem::Specification.new do |gem|

  gem.name        = "hexx-domains"
  gem.version     = Hexx::Domains::VERSION.dup
  gem.author      = "Andrew Kozin"
  gem.email       = "andrew.kozin@gmail.com"
  gem.homepage    = "https://github.com/nepalez/hexx-domains"
  gem.summary     = "Domain model scaffolder."
  gem.description = "Scaffolds the domain model as a separate gem."
  gem.license     = "MIT"

  gem.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files       = Dir["spec/**/*.rb"]
  gem.extra_rdoc_files = Dir["README.md", "LICENSE"]
  gem.require_paths    = ["lib"]

  gem.required_ruby_version = "~> 2.0"
  gem.add_runtime_dependency "hexx-cli", "~> 0.0"
  gem.add_runtime_dependency "hexx-dependencies", "~> 0.0", ">= 0.0.3"
  gem.add_runtime_dependency "hexx-suit", "~> 2.1"

end # Gem::Specification
