require 'pry'

class BrewerySearch::Brewery

    attr_accessor :name, :city, :state, :address, :type, :site_url, :external_site, :facebook_link, :twitter_link, :insta_link
    attr_reader :pages, :brewery_list

    @@all = []
    
    # def initialize(name = nil, city = nil, state = nil, address = nil, site_url = nil, external_site = nil, facebook_link = nil, twitter_link = nil, insta_link = nil)
    #     @name = name
    #     @city = city
    #     @state = state
    #     @address = address
    #     @site_url = url
    #     @external_site = external_site
    #     @facebook_link = facebook_link
    #     @twitter_link = twitter_link
    #     @insta_link = insta_link
    #     @@all << self
    # end

    def self.create_from_state_scrape(input)
        # if BrewerySearch::Scraper.all.find do |x|
        #     if x.state == input

        search_state = BrewerySearch::Scraper.scrape_by_state(input)
        search_state.pages.each do |page|
            page.css("table.breweries-list tbody tr").each do |info|
                new_brewery = BrewerySearch::Brewery.new
                new_brewery.name = info.css("td a.accented.hidden-mobile.bold").text.strip
                new_brewery.city = info.css("td.hidden-mobile")[0].text.split(",")[0].strip
                new_brewery.state = search_state.state
                new_brewery.site_url = info.css("td a.accented.hidden-mobile.bold").attr("href").text.strip
                new_brewery.type = info.css("td.hidden-mobile")[1].text.strip
                @@all << new_brewery
            end
        end
        @@all.sort_by! {|brewery| brewery.name}
    end

    def self.create_profile_attributes(input)
        brewery = self.all.find {|brewery| brewery.name == input}
        profile = BrewerySearch::Scraper.scrape_by_profile(brewery.site_url)
    end

        #pulling out selectors for later:
        # website: doc.css("div.contact a").attr("href").text
        #will need to conditionally pull the following out:
        # facebook: doc.css("div.contact ul.brewer-social-media")[0]
        # twitter: doc.css("div.contact ul.brewer-social-media")[1]
        # instagram: doc.css("div.contact ul.brewer-social-media")[2]

    def self.all
        @@all
    end
end
