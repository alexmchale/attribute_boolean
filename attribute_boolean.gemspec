# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attribute_boolean'

Gem::Specification.new do |spec|
  spec.name          = "attribute_boolean"
  spec.version       = AttributeBoolean::VERSION
  spec.authors       = ["Alex McHale"]
  spec.email         = ["alex@anticlever.com"]
  spec.summary       = %q{A gem for adding attr_boolean to objects}
  spec.description   = %q{A gem for adding attr_boolean to objects, assigning by various 'falsey' values}
  spec.homepage      = "https://github.com/alexmchale/attribute_boolean"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
