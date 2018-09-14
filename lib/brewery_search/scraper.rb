class BrewerySearch::Scraper
    
    def self.scrape_state(state_input)
        search_result_pages = []

        doc = Nokogiri::HTML(open("https://www.brewbound.com/mvc/Breweries/state/#{state_input}?displayOutOfBiz=False"))
        search_result_pages << doc

        #is able to scrape data from additional searrch result pages when applicable, all pages use same format for additional page 
        #results, and user input is injected into url
        page = 2
        while doc.css("table.breweries-list tfoot p.text-center").text.include?("Next") do
            doc = Nokogiri::HTML(open("https://www.brewbound.com/mvc/Breweries/state/#{state_input}/page/#{page}?displayOutOfBiz=False"))
            search_result_pages << doc
            page += 1
        end 

        #instantiates a new Brewery object for each entry
        search_result_pages.each do |additional_page|
            additional_page.css("table.breweries-list tbody tr").each do |tr|
                new_brewery = BrewerySearch::Brewery.new
                new_brewery.name = tr.css("td a.accented.hidden-mobile.bold").text.strip
                new_brewery.city = tr.css("td.hidden-mobile")[0].text.split(",")[0].strip
                new_brewery.state = state_input
                new_brewery.site_url = tr.css("td a.accented.hidden-mobile.bold").attr("href").text.strip
                new_brewery.type = tr.css("td.hidden-mobile")[1].text.strip
            end
        end
    end

    #it will accept a url for a brewery's profile on the page, and scrape additional details to be displayed when requested
    def self.scrape_profile(brewery)
        
        profile = Nokogiri::HTML(open("https://www.brewbound.com#{brewery.site_url}"))
        
        #determining address based one one of several formats the site can use
        if (profile.css("div #overview dl dd dt").text.include?("PARENT") || profile.css("div #overview dl dd dt").text.include?("Founded")) && !!profile.css("div #overview dl dd")[0].text.match(/[0-9]/) == true
            brewery.address = profile.css("div #overview dl dd")[3].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        elsif profile.css("div #overview dl dd dt").text.include?("PARENT") || profile.css("div #overview dl dd dt").text.include?("Founded")
            brewery.address = profile.css("div #overview dl dd")[2].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        elsif profile.css("div #overview dl dd")[0].text.include?("JOB") && !!profile.css("div #overview dl dd")[0].text.match(/[0-9]/) == true
            brewery.address = profile.css("div #overview dl dd")[3].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        elsif profile.css("div #overview dl dd")[0].text.include?("JOB") && !!profile.css("div #overview dl dd")[3].text.match(/[0-9]/) == true
            brewery.address = profile.css("div #overview dl dd")[3].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        elsif profile.css("div #overview dl dt")[2].text.include?("TYPE")
            brewery.address = profile.css("div #overview dl dd")[3].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        else
            brewery.address = profile.css("div #overview dl dd")[2].css("a").attr("href").text.gsub(/\bhttps:.*=(?:,)?/, '')
        end

        #determining overview based on one of several formats the site can use
        if (profile.css("div #overview dl dd dt").text.include?("PARENT") || profile.css("div #overview dl dd dt").text.include?("Founded")) && !!profile.css("div #overview dl dd")[0].text.match(/[0-9]/) == true
            brewery.overview = profile.css("div #overview dl dd")[4].text
        elsif profile.css("div #overview dl dd dt").text.include?("PARENT") || profile.css("div #overview dl dd dt").text.include?("Founded")
            brewery.overview = profile.css("div #overview dl dd")[3].text
        elsif profile.css("div #overview dl dd")[0].text.include?("JOB") && !!profile.css("div #overview dl dd")[0].text.match(/[0-9]/) == true
            brewery.overview = profile.css("div #overview dl dd")[4].text
        elsif profile.css("div #overview dl dd")[0].text.include?("JOB") && !!profile.css("div #overview dl dd")[1].text.match(/[0-9]/) == true
            brewery.overview = profile.css("div #overview dl dd")[4].text
        elsif profile.css("div #overview dl dt")[2].text.include?("TYPE")
            brewery.overview = profile.css("div #overview dl dd")[4].text
        else
            brewery.overview = profile.css("div #overview dl dd")[3].text
        end

        #determine phone number
        if profile.css("div.contact dt")[1].text == "Phone"
            brewery.phone = profile.css("div.contact dd")[1].text
        end

        #determine external website
        brewery.website = profile.css("div.contact a").attr("href").text
        
        #grab social media links depending on what they have available
        social_media = profile.css("div.contact ul.brewer-social-media li").each do |social|
            if social.css("a").attr("href").text.include?("twitter")
                brewery.twitter = social.css("a").attr("href").text
            elsif social.css("a").attr("href").text.include?("facebook")
                brewery.facebook = social.css("a").attr("href").text
            elsif social.css("a").attr("href").text.include?("instagram")
                brewery.instagram = social.css("a").attr("href").text
            elsif social.css("a").attr("href").text.include?("youtube")
                brewery.youtube = social.css("a").attr("href").text
            end
        end
    end
end
