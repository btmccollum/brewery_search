require 'nokogiri'
require 'open-uri'

class BrewerySearch::Scraper

    #will be a collection of scraped states that can be reused to prevent a state from potentially being re-scraped
    @@all = []

    #scrapes the state's page as specified by user and creates a collection from the table
    def self.scrape_from_results(input)
        url = "https://www.brewbound.com/mvc/Breweries/state/#{input}?displayOutOfBiz=False"
        doc = Nokogiri::HTML(open(url))
        
        state_breweries = []

        #will need to account for results that have more than one page, if additional pages are detected the next page will need to be scraped as well
        doc.css("table.breweries-list tr").each do |brewery|
            state_breweries << brewery
        end
    end

    def self.all
        @@all
    end
end
# binding.pry