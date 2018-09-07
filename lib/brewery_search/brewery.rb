class BrewerySearch::Brewery

    attr_accessor :name, :city, :state, :address, :url, :facebook_link, :twitter_link, :insta_link

    @@all = []
    
    def initialize(name = nil, city = nil, state = nil, address = nil, url = nil, facebook_link = nil, twitter_link = nil, insta_link = nil)
        @name = name
        @city = city
        @state = state
        @address = address
        @url = url
        @facebook_link = facebook_link
        @twitter_link = twitter_link
        @insta_link = insta_link
        @@all << self
    end

    def self.create_from_scrape(doc)
    end

    def doc 
        @doc  ||= Nokogiri::HTML(open(self.url))
    end
    

        # #examples:
        # brew_1 = self.new
        # brew_1.name = "Deep Ellum Brewing Co."
        # brew_1.city = "Dallas"
        # brew_1.state = "TX"
        # brew_1.address = "2823 St. Louis St." 
        # brew_1.url = "deepellumbrewing.com"
        # brew_1.facebook_link = "www.facebook.com/deepellumbrewing"
        # brew_1.twitter_link = "www.twitter.com/deepellumbrewing"
        # brew_1.instagram_link = "www.instagram.com/deepellumbrewing"

        # brew_2 = self.new
        # brew_2.name = "Denton County Brewing Co"
        # brew_2.city = "Denton"
        # brew_2.state = "TX"
        # brew_2.address = "200 e McKinney St" 
        # brew_2.url = "dentoncountybrewingco.com"
        # brew_2.facebook_link = "www.facebook.com/Dentoncbc"
        # brew_2.twitter_link = "www.twitter.com/DENTONCBC"

        # [brew_1, brew_2]



    def self.all
        @@all
    end
end
# hash = {:name => "Deep Ellum Brewing Co.", :city => "Dallas", :state => "TX", :address => "2823 St. Louis St.", :url => "deepellumbrewing.com", :facebook_link => "www.facebook.com/deepellumbrewing", :twitter_link => "www.twitter.com/deepellumbrewing", :insta_link => "www.instagram.com/deepellumbrewing"}
# a = BrewerySearch::Brewery.create_from_hash(hash)