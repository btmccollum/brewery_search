class BrewerySearch::Brewery
    attr_accessor :name, :city, :state, :address, :phone, :type, :overview, :site_url, :website_link, :facebook_link, :twitter_link, :instagram_link, :youtube_link
    attr_reader :pages, :brewery_list

    @@all = []

    def initialize
        @@all << self
    end

    def self.find_by_state(state_input)
        self.all.select {|entry| entry.state == state_input}
    end

    def self.find_by_city(city_input)
        self.all.select {|entry| entry.city == city_input} 
    end

    def self.all
        @@all
    end
end
