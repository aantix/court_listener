
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "court_listener/version"

Gem::Specification.new do |spec|
  spec.name          = "court_listener"
  spec.version       = CourtListener::VERSION
  spec.authors       = ["Jim Jones"]
  spec.email         = ["jimjones@legalshieldcorp.com"]

  spec.summary       = %q{Simple search wrapper for Court Listener API}
  spec.description   = %q{Simple search wrapper for Court Listener API}
  spec.homepage      = "https://www.github.com/aantix/court_listener"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 6.0"
  spec.add_development_dependency "webmock", "~> 3.8"
end
