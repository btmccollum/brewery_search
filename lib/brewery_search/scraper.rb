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

        doc = Nokogiri::HTML(open("https://www.brewbound.com/mvc/Breweries/state/#{input}?displayOutOfBiz=False"))
        state_object.pages << doc

        #is able to scrape data from additional pages when applicable
        while doc.css("table.breweries-list tfoot p.text-center").text.include?("Next") do
            doc = Nokogiri::HTML(open("https://www.brewbound.com/mvc/Breweries/state/#{input}/page/#{page}?displayOutOfBiz=False"))
            state_object.pages << doc
            page += 1
        end 

        #creates a collection hashes for each entry from the page
        # pages.each do |page|
        #     page.css("table.breweries-list tbody tr").each do |brewery|
        #         brewery_list << {
        #         :name => brewery.css("td a.accented.hidden-mobile.bold").text.strip,
        #         :city => brewery.css("td.hidden-mobile").first.text.strip,
        #         :state => input,
        #         :site_url => brewery.css("td a.accented.hidden-mobile.bold").attr("href").text.strip,
        #         :type => brewery.css("td.hidden-mobile")[1].text.strip
        #         }
        #     end
        # end
        # @brewery_list = brewery_list
        # @state = input
        # @pages = pages
        @@all << state_object
        state_object
    end

    def self.all
        @@all
    end
end
