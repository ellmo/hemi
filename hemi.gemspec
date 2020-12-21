lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hemi/version"

ERR_RG_2_REQUIRED = "RubyGems 2.0 or newer is required to protect against public gem pushes.".freeze

Gem::Specification.new do |spec|
  # RubyGems < 2.0 does not allow to specify metadata. We do not want to use RubyGems < 2.0
  raise ERR_RG_2_REQUIRED unless spec.respond_to?(:metadata)

  spec.name     = "hemi"
  spec.version  = Hemi::VERSION.dup
  spec.date     = "2020-12-21"
  spec.summary  = "A simplistic game engine based on SDL2. Because I can."
  spec.authors  = ["Jakub Żuchowski"]
  spec.email    = "ellmo@ellmo.net"
  spec.homepage = "https://github.com/ellmo/hemi"
  spec.license  = "MIT"
  # Fetch all git-versioned files, excluding all vendor, test, demo and example locations.
  spec.files    = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(.bundle|demo|examples|spec|features|vendor|assets)/})
  end

  spec.required_ruby_version = ">= 2.6.0"

  spec.add_dependency "pry", "~> 0.12"
  spec.add_dependency "ruby-sdl2", "0.3.5"

  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "rubocop", "~> 0.77"
  spec.add_development_dependency "rubocop-performance", "~> 1.5"
  spec.add_development_dependency "rubocop-rspec", "~> 1.37"
end
