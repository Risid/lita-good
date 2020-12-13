Gem::Specification.new do |spec|
  spec.name          = "lita-good"
  spec.version       = "0.1.0"
  spec.authors       = ["risid"]
  spec.email         = ["risid@qq.com"]
  spec.description   = "good"
  spec.summary       = "good"
  spec.homepage      = "http://localhost:8080/api.php"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.8"

  spec.add_development_dependency "bundler", "2.1.4"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"

  spec.add_development_dependency "nokogiri"
end
