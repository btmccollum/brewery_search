require 'bundler'
Bundler.require

require_all 'lib'

require_relative '../lib/brewery_search.rb'
require_relative '../lib/brewery_search/brewery.rb'
require_relative '../lib/brewery_search/cli.rb'
require_relative '../lib/brewery_search/scraper.rb'
require_relative '../lib/brewery_search/version.rb'