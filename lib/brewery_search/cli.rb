#CLI Controller
class BrewerySearch::CLI

    VALID_STATES = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "TN", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    last_searched_state = nil
    last_searched_city = nil
    last_brew_list_searched = nil
    last_city_list_searched = nil

    #launches the CLI and greets the user with a welcome screen, prompts user to enter a state to search
    def welcome_screen
        puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
        puts "                      ..,,,,,,...   .. .. .  ..              "     
        puts "                      (#                       *             "
        puts "                      ,#   .','.'.'.'.'.'.'.   ,             "
        puts "                      .,,.,.............    ,.,              "
        puts "  Welcome             ,******,,,,,,,,,,,....***@,     /      "
        puts "                      ,/((#(#%##%####((///*,(((&             "    
        puts "    to                *((#(#############(((/((/#     ,,.  *  "
        puts "                      *(((###############(((((//       *.    "
        puts "   Brewery            *((((#######%#####(((/((/(       .,. * "
        puts "                      *((((#############(((/((//        ,. ( "
        puts "    Search            */((##############((((((/*        *. , "
        puts "                      *((((#############(((/((/*        *. ( "  
        puts "                      *(((##############((((((/*        *. . " 
        puts "                      *(((###############(((((/*        *. ( " 
        puts "                      /(((###############(((((/*        ,. * "
        puts "                      /((########%%%#%###(((((/*        ,. / "
        puts "                      /((######%%%%%%%####((#(/*        *,.* " 
        puts "                      /(#####%%%%%%%%%%###((#(/*       *. /  "
        puts "                      /(####%%%%%%%%%%%###((#(%/      ,.. .  "
        puts "                      .((###%%%%%%%%%%%%%###(#(@ ......      "
        puts "                      .((###%%%%%%%%%%%%%###(#(@ ....  .     " 
        puts "                      ,(###%%%%%%%%%%%%%%###(##/             "
        puts "                      ,.*#//%/###(#(##(#//.  ,,/             "
        puts "                      , ./***             ,,,*./             "
        puts "                      , /..             .**...//             "
        puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
        
        self.start
    end

    def start
        input = nil

        puts " Please enter the state abbreviation that you'd like to search: "
        
        input = gets.strip
        @last_searched_state = input
        
            if VALID_STATES.include?(input)
                list_breweries(input)
            else 
                puts "Invalid entry, please enter a valid state."
            end

        self.menu    
    end

    #it will return a list of breweries from the state specified by the user, in alphabetical order by Brewery name
    def list_breweries(input)
        state_listing = nil

        #checks the scraper class variable to ensure the state hasnt already been scraped to avoid unnecessary scraping
        if BrewerySearch::Scraper.all.any? {|entry| entry.state == input}
            state_listing = BrewerySearch::Brewery.all.select {|entry| entry.state == input}
            @last_brew_list_searched = state_listing
        else
            state_listing = BrewerySearch::Brewery.create_from_state_scrape(input) 
            @last_brew_list_searched = state_listing
        end
        
        puts "Displaying results:"

        state_listing.each_with_index {|brewery, index| puts "#{index + 1}. #{brewery.name} -- #{brewery.city}, #{brewery.state} -- #{brewery.type != "" ? brewery.type : "N/A" }"}
    end

    #will return a of breweries in the specified city
    def breweries_by_city
        input = nil

        puts "Please enter the name of the city you would like to filter by:"
        input = gets.strip
        
        # state_listing = BrewerySearch::Brewery.all.select {|brewery| brewery.state == @last_searched_state}
        state_listing = @last_brew_list_searched
        city_listing = state_listing.select {|brewery| brewery.city == input && brewery.state == @last_searched_state}
        @last_city_list_searched = city_listing
        
        puts "Displaying results:"

        city_listing.each_with_index {|brewery, index| puts "#{index + 1}. #{brewery.name} -- #{brewery.city}, #{brewery.state} -- #{brewery.type != "" ? brewery.type : "N/A" }"}

        self.city_menu
    end

    #it will provide the user with a list of options for the breweries returned by #list_breweries
    #will look to change case/when to an if/else to cut down on amount of code
    def menu
        puts "\nPlease enter the number of a brewery for additional information.\nYou can type 'new search' to search again or 'exit' to quit."
        puts "If you would like to filter by a specific city, please type 'city'."

        input = nil
        input = gets.strip

        if input.to_i > 0
            brewery = @last_brew_list_searched[input.to_i - 1]
            brewery.create_profile_attributes
          
            puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
            puts "  Brewery Name: #{brewery.name}"
            puts "  Brewery Address: #{brewery.address != nil ? brewery.address : "N/A"}"
            puts "  Brewery Location: #{brewery.city}, #{brewery.state}"
            puts "  Brewery Phone #: #{brewery.phone != nil ? brewery.phone : "N/A"}"
            puts "  Brewery Type: #{brewery.type != "" ? brewery.type : "N/A" }"
            puts "  Brewery Website: #{brewery.external_site != nil ? brewery.external_site : "N/A" }"
            puts "  Brewery Facebook: #{brewery.facebook_link != nil ? brewery.facebook_link : "N/A" }"
            puts "  Brewery Twitter: #{brewery.twitter_link != nil ? brewery.twitter_link : "N/A" }"
            puts "  Brewery Instagram: #{brewery.insta_link != nil ? brewery.insta_link : "N/A" }"
            puts "  Brewery Youtube: #{brewery.youtube_link != nil ? brewery.youtube_link  : "N/A" }"
            puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"

            puts "You can say 'Website', 'Facebook', 'Twitter', 'Instagram', or 'Youtube'
                  to visit the webpage. Otherwise say 'menu' if you'd like to return, or
                  'exit' if you'd like to quit."
            # puts "Would you like to continue? (y/n)"
            input = gets.strip
                if input == "Website"
                    Launchy.open("#{brewery.external_site}")
                    self.menu
                elsif input == "Facebook"
                    Launchy.open("#{brewery.facebook_link}")
                    self.menu
                elsif input == "Twitter"
                    Launchy.open("#{brewery.twitter_link}")
                    self.menu
                elsif input == "Instagram"
                    Launchy.open("#{brewery.insta_link}")
                    self.menu
                elsif input == "Youtube"
                    Launchy.open("#{brewery.youtube_link}")
                    self.menu
                elsif input == "exit"
                    self.quit
                else
                    self.menu
                end
        elsif input == "new search"
            self.start
        elsif input == "city"
            self.breweries_by_city
        elsif input == exit
            self.quit
        else
            "Invalid entry received. Please select a number, 'city', 'new search', or 'exit'."
        end
    end

    def city_menu
        puts "\nPlease enter the number of a brewery for additional information.\nYou can type 'new search' to search again or 'exit' to quit."
        puts "If you would like to filter by a specific city, please type 'city'."

        input = nil
        input = gets.strip

        if input.to_i > 0
            brewery = @last_city_list_searched[input.to_i - 1]
            brewery.create_profile_attributes
          
            puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
            puts "  Brewery Name: #{brewery.name}"
            puts "  Brewery Address: #{brewery.address != nil ? brewery.address : "N/A"}"
            puts "  Brewery Location: #{brewery.city}, #{brewery.state}"
            puts "  Brewery Phone #: #{brewery.phone != nil ? brewery.phone : "N/A"}"
            puts "  Brewery Type: #{brewery.type != "" ? brewery.type : "N/A" }"
            puts "  Brewery Website: #{brewery.external_site != nil ? brewery.external_site : "N/A" }"
            puts "  Brewery Facebook: #{brewery.facebook_link != nil ? brewery.facebook_link : "N/A" }"
            puts "  Brewery Twitter: #{brewery.twitter_link != nil ? brewery.twitter_link : "N/A" }"
            puts "  Brewery Instagram: #{brewery.insta_link != nil ? brewery.insta_link : "N/A" }"
            puts "  Brewery Youtube: #{brewery.youtube_link != nil ? brewery.youtube_link  : "N/A" }"
            puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"

            puts "You can say 'Website', 'Facebook', 'Twitter', 'Instagram', or 'Youtube'
                  to visit the page. Otherwise say 'menu' if you'd like to return, or
                  'exit' if you'd like to quit."
            # puts "Would you like to continue? (y/n)"
            input = gets.strip
                if input == "Website"
                    Launchy.open("#{brewery.external_site}")
                    self.menu
                elsif input == "Facebook"
                    Launchy.open("#{brewery.facebook_link}")
                    self.menu
                elsif input == "Twitter"
                    Launchy.open("#{brewery.twitter_link}")
                    self.menu
                elsif input == "Instagram"
                    Launchy.open("#{brewery.insta_link}")
                    self.menu
                elsif input == "Youtube"
                    Launchy.open("#{brewery.youtube_link}")
                    self.city_menu
                elsif input == "exit"
                    self.quit
                else
                    self.menu
                end
        elsif input == "new search"
            self.start
        elsif input == "city"
            self.breweries_by_city
        elsif input == exit
            self.quit
        else
            "Invalid entry received. Please select a number, 'city', 'new search', or 'exit'."
        end
    end

    #it will terminate the program if the user so chooses
    def quit
        puts "Thank you for using Brewery Search. Have a great day!"
    end
end
