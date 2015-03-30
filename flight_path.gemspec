# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flight_path/version'

Gem::Specification.new do |spec|
  spec.name          = "flight_path"
  spec.version       = FlightPath::VERSION
  spec.authors       = ["Chuck Shaw"]
  spec.email         = ["chuck.shaw@gmail.com"]
  spec.summary       = %q{Simulated Flight Path Generator.}
  spec.description   = %q{SSimple tool to take a set of lat/lon/alt/velocity values from an excel spreadsheet and calculate remaining column values to generate a simulated flight path.}
  spec.homepage      = "https://github.com/chuckshaw/flight_path"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
