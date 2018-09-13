require "rubygems"
require "bundler"
Bundler.require
require "nokogiri"
require "open-uri"

require_relative "../lib/brewery_search/version.rb"
require_relative "../lib/brewery_search/brewery.rb"
require_relative "../lib/brewery_search/cli.rb"
require_relative "../lib/brewery_search/scraper.rb"
