class BrewerySearch::Brewery

    attr_accessor :name, :city, :state, :address, :url, :facebook_link, :twitter_link, :instagram_link

    @@all = []
    
    def initialize #(name = nil, city = nil, state = nil, address = nil, url = nil, facebook_link = nil, twitter_link = nil, instagram_link = nil)
        @name = name
        @city = city
        @state = state
        @address = address
        @url = url
        @facebook_link = facebook_link
        @twitter_link = twitter_link
        @instagram_link = instagram_link
    end

    #instantiate a new Brewery object from the hash returned from scraping the results of the user's search
    def self.create_by_search #(brewery_hash)
        # brew_1 = self.new
        # brew_1.name = ""
        # brew_1.city = ""
        # brew_1.state = ""
        # brew_1.address = "" 
        # brew_1.url = ""
        # brew_1.facebook_link = ""
        # brew_1.twitter_link = ""
        # brew_1.instagram_link = ""

        #examples:
        brew_1 = self.new
        brew_1.name = "Deep Ellum Brewing Co."
        brew_1.city = "Dallas"
        brew_1.state = "TX"
        brew_1.address = "2823 St. Louis St." 
        brew_1.url = "deepellumbrewing.com"
        brew_1.facebook_link = "www.facebook.com/deepellumbrewing"
        brew_1.twitter_link = "www.twitter.com/deepellumbrewing"
        brew_1.instagram_link = "www.instagram.com/deepellumbrewing"

        brew_2 = self.new
        brew_2.name = "Denton County Brewing Co"
        brew_2.city = "Denton"
        brew_2.state = "TX"
        brew_2.address = "200 e McKinney St" 
        brew_2.url = "dentoncountybrewingco.com"
        brew_2.facebook_link = "www.facebook.com/Dentoncbc"
        brew_2.twitter_link = "www.twitter.com/DENTONCBC"

        [brew_1, brew_2]
    end

end
