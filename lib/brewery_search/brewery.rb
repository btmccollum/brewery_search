class BrewerySearch::Brewery
    attr_accessor :name, :city, :state, :address, :phone, :type, :overview, :site_url, :external_site, :facebook_link, :twitter_link, :insta_link, :youtube_link
    attr_reader :pages, :brewery_list

    @@all = []

    #creates a brewery entry for every result returned by the scraped state
    def self.create_from_state_scrape(input)
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
                search_state.brewery_list << new_brewery
            end
        end
        @@all.sort_by! {|brewery| brewery.name}
    end

    #creates additional information from the breweries individual page entry only when called for
    def create_profile_attributes
        profile = BrewerySearch::Scraper.scrape_by_profile(self.site_url)
        
        #determining address based one one of several formats the site can use
        if (profile.css("div #overview dl dd dt").text.include?("PARENT") || profile.css("div #overview dl dd dt").text.include?("Founded")) && !!profile.css("div #overview dl dd")[0].text.match(/[0-9]/) == true
            self.address = profile.css("div #overview dl dd")[3].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        elsif profile.css("div #overview dl dd dt").text.include?("PARENT") || profile.css("div #overview dl dd dt").text.include?("Founded")
            self.address = profile.css("div #overview dl dd")[2].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        elsif profile.css("div #overview dl dd")[0].text.include?("JOB") && !!profile.css("div #overview dl dd")[0].text.match(/[0-9]/) == true
            self.address = profile.css("div #overview dl dd")[3].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        elsif profile.css("div #overview dl dd")[0].text.include?("JOB") && !!profile.css("div #overview dl dd")[3].text.match(/[0-9]/) == true
            self.address = profile.css("div #overview dl dd")[3].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        else
            self.address = profile.css("div #overview dl dd")[2].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        end

        #determining overview based on one of several formats the site can use
        if (profile.css("div #overview dl dd dt").text.include?("PARENT") || profile.css("div #overview dl dd dt").text.include?("Founded")) && !!profile.css("div #overview dl dd")[0].text.match(/[0-9]/) == true
            self.overview = profile.css("div #overview dl dd")[4].text
        elsif profile.css("div #overview dl dd dt").text.include?("PARENT") || profile.css("div #overview dl dd dt").text.include?("Founded")
            self.overview = profile.css("div #overview dl dd")[3].text
        elsif profile.css("div #overview dl dd")[0].text.include?("JOB") && !!profile.css("div #overview dl dd")[0].text.match(/[0-9]/) == true
            self.overview = profile.css("div #overview dl dd")[4].text
        elsif profile.css("div #overview dl dd")[0].text.include?("JOB") && !!profile.css("div #overview dl dd")[3].text.match(/[0-9]/) == true
            self.address = profile.css("div #overview dl dd")[3].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        else
            self.overview = profile.css("div #overview dl dd")[3].text
        end

        #determine phone number
        if profile.css("div.contact dt")[1].text == "Phone"
            self.phone = profile.css("div.contact dd")[1].text
        end

        #determine external website
        self.external_site = profile.css("div.contact a").attr("href").text
        
        #grab social media links depending on what they have available
        social_media = profile.css("div.contact ul.brewer-social-media li").each do |social|
            if social.css("a").attr("href").text.include?("twitter")
                self.twitter_link = social.css("a").attr("href").text
            elsif social.css("a").attr("href").text.include?("facebook")
                self.facebook_link = social.css("a").attr("href").text
            elsif social.css("a").attr("href").text.include?("instagram")
                self.insta_link = social.css("a").attr("href").text
            elsif social.css("a").attr("href").text.include?("youtube")
                self.youtube_link = social.css("a").attr("href").text
            end
        end
    end

    def self.all
        @@all
    end
end
