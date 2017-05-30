Gem::Specification.new do |spec|
  spec.name          = "lita-way-to-go"
  spec.version       = "0.1.0"
  spec.authors       = ["Henning Gebhard"]
  spec.email         = ["henning.gebhard@rub.de"]
  spec.description   = "Tells you the way. Kind of."
  spec.summary       = "Never gonna give you up, never gonna let you down, never gonna run around and desert you."
  spec.homepage      = "https://github.com/arbox/chatbot2"
  spec.license       = "TODO: Add a license"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.7"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
