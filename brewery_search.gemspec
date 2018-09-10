lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "brewery_search/version"

Gem::Specification.new do |spec|
  spec.name          = "brewery_search"
  spec.version       = BrewerySearch::VERSION
  spec.authors       = ["btmccollum"]
  spec.email         = ["btmcco8@gmail.com"]

  spec.summary       = "A CLI brewery directory leveraging BrewBound"
  spec.description   = "Allows a user to search for breweries by state by utilizing the www.brewbound.com brewery database. Results will be returned as a numbered list. Contains a welcome screen upon launch and will have several prompts for a user to follow."
  spec.homepage      = "https://github.com/btmccollum/brewery_search"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["brewery-search"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "require_all", "~> 2.0"
  spec.add_development_dependency "nokogiri", "~> 1.8", ">= 1.8.4"
  spec.add_development_dependency "launchy", "~> 2.4", ">= 2.4.3"
  
end
