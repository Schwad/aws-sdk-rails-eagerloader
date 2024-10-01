Gem::Specification.new do |spec|
  spec.name          = "aws-sdk-rails-eagerloader"
  spec.version       = "0.1.0"
  spec.authors       = ['Amazon Web Services']
  spec.email         = ['aws-dr-rubygems@amazon.com']

  spec.summary       = "Eager loading functionality for AWS SDK in Rails"
  spec.description   = "A Rails plugin that provides eager loading for AWS SDK to optimize load times"
  spec.homepage      = "https://github.com/Schwad/aws-sdk-rails-eagerloader"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 7.0.0"
  spec.add_dependency "aws-sdk-core", "~> 3"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
