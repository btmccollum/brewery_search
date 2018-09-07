require 'nokogiri'
require 'open-uri'

class BrewerySearch::Scraper

    attr_accessor :state, :pages, :brewery_list

    #will be a collection of scraped states that can be reused to prevent a state from potentially being re-scraped
    @@all = []

    #scrapes the state's page as specified by user and creates a collection from the table
    def scrape_from_results(input)
        pages = []
        brewery_list = []
        
        page = 2

        doc = Nokogiri::HTML(open("https://www.brewbound.com/mvc/Breweries/state/#{input}?displayOutOfBiz=False"))
        pages << doc

        #is able to scrape data from additional pages when applicable
        while doc.css("table.breweries-list tfoot p.text-center").text.include?("Next") do
            doc = Nokogiri::HTML(open("https://www.brewbound.com/mvc/Breweries/state/#{input}/page/#{page}?displayOutOfBiz=False"))
            pages << doc
            page += 1
        end 

        #creates a collection hashes for each entry from the page
        pages.each do |page|
            page.css("table.breweries-list tbody tr").each do |brewery|
                brewery_list << {
                :name => brewery.css("td a.accented.hidden-mobile.bold").text.strip,
                :city => brewery.css("td.hidden-mobile").first.text.strip,
                :state => input,
                :site_url => brewery.css("td a.accented.hidden-mobile.bold").attr("href").text.strip,
                :type => brewery.css("td.hidden-mobile")[1].text.strip
                }
            end
        end

        @state = input
        @pages = pages
        @brewery_list = brewery_list
        @@all << self
    end

    def self.all
        @@all
    end
end
