require 'nokogiri'
require 'open-uri'

class BrewerySearch::Scraper

    def self.scrape_from_results(input)
        url = "https://www.brewbound.com/mvc/Breweries/state/#{input}?displayOutOfBiz=False"
        doc = Nokogiri::HTML(open(url))
        # binding.pry

        state_breweries = []

        doc.css("table.breweries-list tr").each do |brewery|
            state_breweries << brewery
        end
        state_breweries.count
    end


end
# binding.pry