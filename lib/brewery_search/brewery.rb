class BrewerySearch::Brewery

    attr_accessor :name, :city, :state, :address, :url, :external_site, :facebook_link, :twitter_link, :insta_link

    @@all = []
    
    def initialize(name = nil, city = nil, state = nil, address = nil, site_url = nil, external_site = nil, facebook_link = nil, twitter_link = nil, insta_link = nil)
        @name = name
        @city = city
        @state = state
        @address = address
        @site_url = url
        @external_site = external_site
        @facebook_link = facebook_link
        @twitter_link = twitter_link
        @insta_link = insta_link
        @@all << self
    end

    # def self.create_from_scrape(input)
    #     do
    # end

    def self.all
        @@all
    end
end
