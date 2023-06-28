# frozen_string_literal: true

require_relative "lib/bababaroomba/version"

Gem::Specification.new do |spec|
  spec.name = "bababaroomba"
  spec.version = Bababaroomba::VERSION
  spec.authors = ["Richard Conroy"]
  spec.email = ["richard.conroy@gmail.com"]

  spec.summary = "Simulation of a cleaning robot"
  spec.description = "Experiments in pathfinding and virtual cleaning"
  spec.homepage = "https://example.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://example.com/source"
  spec.metadata["changelog_uri"] = "https://example.com/changelog"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "brakeman"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "pronto"
  spec.add_development_dependency "pronto-flay"
  spec.add_development_dependency "pronto-reek"
  spec.add_development_dependency "pronto-rubocop"
  spec.add_development_dependency "pronto-undercover"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "simplecov-lcov"
  spec.add_development_dependency "undercover"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
