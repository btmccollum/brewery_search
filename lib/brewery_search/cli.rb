#CLI Controller
class BrewerySearch::CLI
    VALID_STATES = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

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
        state_input = nil
        puts "Please enter the abbreviation for the state you'd like to search: "
        
        state_input = gets.strip.upcase
        @last_searched_state = state_input

        if VALID_STATES.include?(state_input)
            self.list_breweries(state_input)
        elsif input.downcase == "exit"
            self.quit
        elsif input.downcase == "brewbound"
            Launchy.open("https://www.brewbound.com/")
        else
            puts "Invalid entry received."
            self.start
        end
      self.menu    
    end

    #it will return a list of breweries from the state specified by the user, in alphabetical order by Brewery name
    def list_breweries(state_input)
        #checking to ensure we have not already scraped the state being searched
        if BrewerySearch::Brewery.find_by_state(state_input) != []
            @last_brew_list_searched = BrewerySearch::Brewery.find_by_state(state_input)
        else 
            BrewerySearch::Scraper.scrape_state(state_input)
            @last_brew_list_searched = BrewerySearch::Brewery.find_by_state(state_input)
        end
   
        #to be used in validation check in #menu
        @last_search = @last_brew_list_searched

        puts "Displaying results:"
        @last_brew_list_searched.map.with_index {|brewery, index| puts "#{index + 1}. #{brewery.name} -- #{brewery.city}, #{brewery.state} -- #{brewery.type != "" ? brewery.type : "N/A" }"}
    end

    #will return a list of breweries in the specified city
    def breweries_by_city
        city_input = nil
        puts "Please enter the name of the city you would like to filter by:"
        city_input = gets.strip.downcase.split.map{|word| word.capitalize}.join(' ')
        
        @last_city_list_searched = BrewerySearch::Brewery.find_by_city(city_input)
       
        #to be used in validation check in #menu
        @last_search = @last_city_list_searched

        puts "Displaying results:"
        @last_city_list_searched.map.with_index {|brewery, index| puts "#{index + 1}. #{brewery.name} -- #{brewery.city}, #{brewery.state} -- #{brewery.type != "" ? brewery.type : "N/A" }"}

        self.menu
    end

    #creates flow for allowing user to select a specific brewery and obtain additional info or take other actions
    def menu
        puts "\nPlease enter the number of a brewery for additional information.\nYou can type 'new search' to search again or 'exit' to quit."
        puts "If you would like to filter by a specific city, please type 'city'."

        input = nil
        input = gets.strip.downcase

        #control flow for user input
        if (input.to_i > 0) && (input.to_i <= @last_search.size)
            brewery = @last_search[input.to_i - 1]

            #checks to ensure the profile for the brewery being checked has not been scraped already
            brewery.address != nil ? brewery : BrewerySearch::Scraper.scrape_profile(brewery) 
          
            #implements logic based on user's current search path(state or city filter) to present the correct brewery and options
            self.ind_brewery_info(brewery)

            #the #result_call above prompts the user for another input
            options_input = gets.strip.downcase
                if options_input == "website"
                    Launchy.open("#{brewery.website_link}") {|exception| puts "Attempted to open #{brewery.website_link} but failed due to : #{exception}"}
                    self.menu 
                elsif options_input == "facebook"
                    Launchy.open("#{brewery.facebook_link}") {|exception| puts "Attempted to open #{brewery.facebook_link} but failed due to : #{exception}"}
                    self.menu 
                elsif options_input == "twitter"
                    Launchy.open("#{brewery.twitter_link}") {|exception| puts "Attempted to open #{brewery.twitter_link} but failed due to : #{exception}"}
                    self.menu 
                elsif options_input == "instagram"
                    Launchy.open("#{brewery.instagram_link}") {|exception| puts "Attempted to open #{brewery.instagram_link} but failed due to : #{exception}"}
                    self.menu 
                elsif options_input == "youtube"
                    Launchy.open("#{brewery.youtube_link}") {|exception| puts "Attempted to open #{brewery.youtube_link} but failed due to : #{exception}"}
                    self.menu 
                elsif options_input == "exit"
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

    #returns an info sheet for a given brewery
    def ind_brewery_info(brewery)
        puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
        puts "Brewery Name: #{brewery.name}"
        puts "Brewery Address: #{brewery.address != nil ? brewery.address : "N/A"}"
        puts "Brewery Location: #{brewery.city}, #{brewery.state}"
        puts "Brewery Phone #: #{brewery.phone != nil ? brewery.phone : "N/A"}"
        puts "Brewery Type: #{brewery.type != "" ? brewery.type : "N/A" }"
        puts "Brewery Website: #{brewery.website_link != nil ? brewery.website_link : "N/A" }"
        puts "Brewery Facebook: #{brewery.facebook_link != nil ? brewery.facebook_link : "N/A" }"
        puts "Brewery Twitter: #{brewery.twitter_link != nil ? brewery.twitter_link : "N/A" }"
        puts "Brewery Instagram: #{brewery.instagram_link != nil ? brewery.instagram_link : "N/A" }"
        puts "Brewery Youtube: #{brewery.youtube_link != nil ? brewery.youtube_link  : "N/A" }"
        puts ""
        puts "Brewery Overview: #{brewery.overview}"
        puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
        puts "You can say 'Website', 'Facebook', 'Twitter', 'Instagram', or"
        puts "'Youtube' to visit the page. Otherwise say 'menu' if you'd like"
        puts "to return, or 'exit' if you'd like to quit."
    end

    #it will terminate the program if the user so chooses
    def quit
        puts "Thank you for using Brewery Search. Have a great day!"
        exit
    end
end
