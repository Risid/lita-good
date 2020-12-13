Gem::Specification.new do |spec|
  spec.name          = "lita-what"
  spec.version       = "0.1.0"
  spec.authors       = ["risid"]
  spec.email         = ["risid@qq.com"]
  spec.description   = "What is bala"
  spec.summary       = "What is bala"
  spec.homepage      = "http://kw.fudan.edu.cn/apis/cndbpedia/"
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
end
