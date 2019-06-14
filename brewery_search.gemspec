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

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "bin"
  spec.executables   = ["brewery-search"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.11.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "nokogiri", "~> 1.8", ">= 1.8.4"
  spec.add_dependency "launchy", "~> 2.4", ">= 2.4.3"
end
