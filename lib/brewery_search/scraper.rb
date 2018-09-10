require 'nokogiri'
require 'open-uri'

class BrewerySearch::Scraper
    attr_accessor :state, :pages, :brewery_list

    #will be a collection of scraped states that can be reused to prevent a state from potentially being re-scraped
    @@all = []

    #scrapes the state's page as specified by user and creates a collection from the table
    def self.scrape_by_state(input)
        state_object = BrewerySearch::Scraper.new
        state_object.state = input
        state_object.pages = []
        state_object.brewery_list = []
        
        page = 2

        #all state search pages use same HTML format, user input for state abbreviation is injected
        doc = Nokogiri::HTML(open("https://www.brewbound.com/mvc/Breweries/state/#{input}?displayOutOfBiz=False"))
        state_object.pages << doc

        #is able to scrape data from additional pages when applicable, all pages use same format for additional page results, # and user input are injected
        while doc.css("table.breweries-list tfoot p.text-center").text.include?("Next") do
            doc = Nokogiri::HTML(open("https://www.brewbound.com/mvc/Breweries/state/#{input}/page/#{page}?displayOutOfBiz=False"))
            state_object.pages << doc
            page += 1
        end 

        @@all << state_object
        state_object
    end

    #it will accept a url for a brewery's profile on the page, and scrape additional details to be displayed when requested
    def self.scrape_by_profile(input)
        doc = Nokogiri::HTML(open("https://www.brewbound.com#{input}"))
    end

    def self.all
        @@all
    end
end
