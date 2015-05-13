Gem::Specification.new do |spec|
  spec.name          = "lita-googl"
  spec.version       = "0.0.1"
  spec.authors       = ["Miroslav Yovchev"]
  spec.email         = ["m.yovchev@corllete.com"]
  spec.description   = %q(Lita handler - shorten URL via goo.gl)
  spec.summary       = %q(Lita handler - shorten URL via goo.gl)
  spec.homepage      = "https://github.com/myovchev/lita-googl"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.3"
  spec.add_runtime_dependency "googl", "< 1.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
