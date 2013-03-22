# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'globalize3_jquery_autocomplete/version'

Gem::Specification.new do |spec|
  spec.name          = "globalize3-jquery-autocomplete"
  spec.version       = Globalize3JqueryAutocomplete::VERSION
  spec.authors       = ["Maximilian Herold"]
  spec.email         = ["herold@emjot.de"]
  spec.description   = %q{Enable rails3-jquery-autocomplete to work with globalize3 translated models.}
  spec.summary       = %q{rails3-jquery-autocomplete with globalize3 translated models}
  spec.homepage      = "https://github.com/emjot/globalize3-jquery-autocomplete"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails", "~> 3.0"
  spec.add_runtime_dependency "globalize3", "~> 0.3"
  spec.add_runtime_dependency "rails3-jquery-autocomplete", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
