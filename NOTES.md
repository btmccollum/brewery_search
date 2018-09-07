Website to scrape: https://www.brewbound.com/breweries 

1) Plan your gem, imagine your interface
2) Start with the project structure - google
3) Start with the entry point - the file run
4) force that to build the CLI interface
5) stub out the interface
6) start making things real
7) discover objects
8) program

1) Planning gem:
    -a command line interface for discovering what breweries are in your state that can be filtered down by city name (not zip code)

    -a user is asked to provide the name of a state by name/abbreviation and/or city and state together

    -user is then provided with a numbered list of breweries located in their state, sorted alphabetically

        EX:
            1) Deep Ellem Brewing Co. -- Dallas -- Brewery
            2) Hopfusion -- Fort Worth -- Microbrewery
            3) Rahr -- Fort Worth -- Brewery

        -If you'd like to see additional information about any brewery, please enter the number below:

        -At any time a user can call menu to be presented several additional options such as:
            1) New search
            2) Quit

2

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

        # hash = {:name => "Deep Ellum Brewing Co.", :city => "Dallas", :state => "TX", :address => "2823 St. Louis St.", :url => "deepellumbrewing.com", :facebook_link => "www.facebook.com/deepellumbrewing", :twitter_link => "www.twitter.com/deepellumbrewing", :insta_link => "www.instagram.com/deepellumbrewing"}
# a = BrewerySearch::Brewery.create_from_hash(hash)


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