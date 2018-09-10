#CLI Controller
class BrewerySearch::CLI
    VALID_STATES = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    @last_searched_state = nil
    @last_searched_city = nil
    @last_brew_list_searched = nil
    @last_city_list_searched = nil

    #launches the CLI and greets the user with a welcome screen, prompts user to enter a state to search
    def welcome_screen
        puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
        puts "AL                      ..,,,,,,...   .. .. .  ..                MT"     
        puts "AK                      (#                       *               NE"
        puts "AZ                      ,#   .','.'.'.'.'.'.'.   ,               NV"
        puts "AR                      .,,.,.............    ,.,                NH"
        puts "CA                      ,******,,,,,,,,,,,....***@,     /        NJ"
        puts "CO                      ,/((#(#%##%####((///*,(((&               NM"    
        puts "CT  Welcome             *((#(#############(((/((/#     ,,.  *    NY"
        puts "DE                      *(((###############(((((//       *.      NC"
        puts "FL     to               *((((#######%#####(((/((/(       .,. *   ND"
        puts "GA                      *((((#############(((/((//        ,. (   OH"
        puts "HI    Brewery           */((##############((((((/*        *. ,   OK"
        puts "ID                      *((((#############(((/((/*        *. (   OR"  
        puts "IL      Search          *(((##############((((((/*        *. .   PA"  
        puts "IN                      *(((###############(((((/*        *. (   RI" 
        puts "IA                      /(((###############(((((/*        ,. *   SC"
        puts "KA                      /((########%%%#%###(((((/*        ,. /   SD"
        puts "KY                      /((######%%%%%%%####((#(/*        *,.*   TN" 
        puts "LA                      /(#####%%%%%%%%%%###((#(/*       *. /    TX"
        puts "ME                      /(####%%%%%%%%%%%###((#(%/      ,.. .    UT"
        puts "MD                      .((###%%%%%%%%%%%%%###(#(@ ......        VT"
        puts "MA                      .((###%%%%%%%%%%%%%###(#(@ ....  .       VA" 
        puts "MI                      ,(###%%%%%%%%%%%%%%###(##/               WA"
        puts "MN                      ,.*#//%/###(#(##(#//.  ,,/               WV"
        puts "MS                      , ./***             ,,,*./               WI"
        puts "MO                      , /..             .**...//               WY"
        puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
        puts "*     All information contained is referenced from BrewBound.     *"
        puts "*                Type 'BrewBound' to visit them!                  *"
        puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
        self.start
    end

    def start
        input = nil

        puts "Please enter the abbreviation for the state you'd like to search: "
        
        input = gets.strip
        @last_searched_state = input
            if VALID_STATES.include?(input)
                list_breweries(input)
            elsif input == "exit"
                self.quit
            elsif input == "BrewBound"
                Launchy.open ("https://www.brewbound.com/")
            else
                puts "Invalid entry received."
                self.start
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

    def options_call
        puts "\nPlease enter the number of a brewery for additional information.\nYou can type 'new search' to search again or 'exit' to quit."
        puts "If you would like to filter by a specific city, please type 'city'."
    end

    #usuable only from #menu, has to be able to recall the previously used state
    def state_result_call(input)
            brewery = @last_brew_list_searched[input.to_i - 1]
            puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
            puts "Brewery Name: #{brewery.name}"
            puts "Brewery Address: #{brewery.address != nil ? brewery.address : "N/A"}"
            puts "Brewery Location: #{brewery.city}, #{brewery.state}"
            puts "Brewery Phone #: #{brewery.phone != nil ? brewery.phone : "N/A"}"
            puts "Brewery Type: #{brewery.type != "" ? brewery.type : "N/A" }"
            puts "Brewery Website: #{brewery.external_site != nil ? brewery.external_site : "N/A" }"
            puts "Brewery Facebook: #{brewery.facebook_link != nil ? brewery.facebook_link : "N/A" }"
            puts "Brewery Twitter: #{brewery.twitter_link != nil ? brewery.twitter_link : "N/A" }"
            puts "Brewery Instagram: #{brewery.insta_link != nil ? brewery.insta_link : "N/A" }"
            puts "Brewery Youtube: #{brewery.youtube_link != nil ? brewery.youtube_link  : "N/A" }"
            puts ""
            puts "Brewery Overview: #{brewery.overview}"
            puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
            puts "You can say 'Website', 'Facebook', 'Twitter', 'Instagram', or"
            puts "'Youtube' to visit the page. Otherwise say 'menu' if you'd like"
            puts "to return, or 'exit' if you'd like to quit."
    end

    #usable only from #city_menu, has to be able to recall the previously used city as to not interrupt flow
    def city_result_call(input)
        brewery = @last_city_list_searched[input.to_i - 1]
            puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
            puts "Brewery Name: #{brewery.name}"
            puts "Brewery Address: #{brewery.address != nil ? brewery.address : "N/A"}"
            puts "Brewery Location: #{brewery.city}, #{brewery.state}"
            puts "Brewery Phone #: #{brewery.phone != nil ? brewery.phone : "N/A"}"
            puts "Brewery Type: #{brewery.type != "" ? brewery.type : "N/A" }"
            puts "Brewery Website: #{brewery.external_site != nil ? brewery.external_site : "N/A" }"
            puts "Brewery Facebook: #{brewery.facebook_link != nil ? brewery.facebook_link : "N/A" }"
            puts "Brewery Twitter: #{brewery.twitter_link != nil ? brewery.twitter_link : "N/A" }"
            puts "Brewery Instagram: #{brewery.insta_link != nil ? brewery.insta_link : "N/A" }"
            puts "Brewery Youtube: #{brewery.youtube_link != nil ? brewery.youtube_link  : "N/A" }"
            puts ""
            puts "Brewery Overview: #{brewery.overview}"
            puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
            puts "You can say 'Website', 'Facebook', 'Twitter', 'Instagram', or"
            puts "'Youtube' to visit the page. Otherwise say 'menu' if you'd like"
            puts "to return, or 'exit' if you'd like to quit."
    end

    #it will provide the user with a list of options for the breweries returned by #list_breweries
    def menu
        self.options_call

        input = nil
        input = gets.strip

        #has to use @last_brew_list_searched in order to continue to use state specific results
        if (input.to_i > 0) && (input.to_i <= @last_brew_list_searched.size)
            brewery = @last_brew_list_searched[input.to_i - 1]
            brewery.create_profile_attributes
          
            self.state_result_call(input)
            
            input = gets.strip
                if input == "Website"
                    Launchy.open("#{brewery.external_site}") {|exception| puts "Attempted to open #{brewery.external_site} but failed due to : #{exception}"}
                    self.menu
                elsif input == "Facebook"
                    Launchy.open("#{brewery.facebook_link}") {|exception| puts "Attempted to open #{brewery.facebook_link} but failed due to : #{exception}"}
                    self.menu
                elsif input == "Twitter"
                    Launchy.open("#{brewery.twitter_link}") {|exception| puts "Attempted to open #{brewery.twitter_link} but failed due to : #{exception}"}
                    self.menu
                elsif input == "Instagram"
                    Launchy.open("#{brewery.insta_link}") {|exception| puts "Attempted to open #{brewery.insta_link} but failed due to : #{exception}"}
                    self.menu
                elsif input == "Youtube"
                    Launchy.open("#{brewery.youtube_link}") {|exception| puts "Attempted to open #{brewery.youtube_link} but failed due to : #{exception}"}
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
        elsif input == "exit"
            self.quit
        else
            puts "Invalid entry received. Please select a number, 'city', 'new search', or 'exit'."
            self.menu
        end
    end

    #it will provide the user with a list of options for the breweries returned by #city_breweries
    def city_menu
        self.options_call

        input = nil
        input = gets.strip

        #has to utilize @last_city_list_searched in order to continue to use city specific results
        if (input.to_i > 0) && (input.to_i <= @last_city_list_searched.size)
            brewery = @last_city_list_searched[input.to_i - 1]
            brewery.create_profile_attributes
          
            self.city_result_call(input)
            
            input = gets.strip
                if input == "Website"
                    Launchy.open("#{brewery.external_site}") {|exception| puts "Attempted to open #{brewery.external_site} but failed due to : #{exception}"}
                    self.city_menu 
                elsif input == "Facebook"
                    Launchy.open("#{brewery.facebook_link}") {|exception| puts "Attempted to open #{brewery.facebook_link} but failed due to : #{exception}"}
                    self.city_menu 
                elsif input == "Twitter"
                    Launchy.open("#{brewery.twitter_link}") {|exception| puts "Attempted to open #{brewery.twitter_link} but failed due to : #{exception}"}
                    self.city_menu 
                elsif input == "Instagram"
                    Launchy.open("#{brewery.insta_link}") {|exception| puts "Attempted to open #{brewery.insta_link} but failed due to : #{exception}"}
                    self.city_menu 
                elsif input == "Youtube"
                    Launchy.open("#{brewery.youtube_link}") {|exception| puts "Attempted to open #{brewery.youtube_link} but failed due to : #{exception}"}
                    self.city_menu 
                elsif input == "exit"
                    self.quit
                else
                    self.city_menu
                end
        elsif input == "new search"
            self.start
        elsif input == "city"
            self.breweries_by_city
        elsif input == "exit"
            self.quit
        else
            puts "Invalid entry received. Please select a number, 'city', 'new search', or 'exit'."
            self.city_menu
        end
    end

    #it will terminate the program if the user so chooses
    def quit
        puts "Thank you for using Brewery Search. Have a great day!"
        exit
    end
end
