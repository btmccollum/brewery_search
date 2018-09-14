require 'pry'
class BrewerySearch::CLI
    VALID_STATES = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

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
        puts "Please enter the abbreviation for the state you'd like to search:"
        
        @last_searched_state = gets.strip.upcase
      
        if VALID_STATES.include?(@last_searched_state)
            self.list_breweries(@last_searched_state)
        elsif @last_searched_state.downcase == "exit"
            self.quit
        elsif @last_searched_state.downcase == "brewbound"
            Launchy.open("https://www.brewbound.com/")
            self.start
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
            @last_search = BrewerySearch::Brewery.find_by_state(state_input)
        else 
            BrewerySearch::Scraper.scrape_state(state_input)
            @last_search = BrewerySearch::Brewery.find_by_state(state_input)
        end

        puts "Displaying results:"
        puts ""
        @last_search.each.with_index {|brewery, index| puts "#{index + 1}. #{brewery.name} -- #{brewery.city}, #{brewery.state} -- #{brewery.type != "" ? brewery.type : "N/A" }"}
    end

    #will return a list of breweries in the specified city
    def breweries_by_city
        city_input = nil
        puts "Please enter the name of the city you would like to filter by:"
        city_input = gets.strip.downcase.split.map{|word| word.capitalize}.join(' ')
        
        @last_search = BrewerySearch::Brewery.find_by_city(city_input)

        puts "Displaying results:"
        @last_search.each.with_index {|brewery, index| puts "#{index + 1}. #{brewery.name} -- #{brewery.city}, #{brewery.state} -- #{brewery.type != "" ? brewery.type : "N/A" }"}

        self.menu
    end

    #creates flow for allowing user to select a specific brewery and obtain additional info or take other actions
    def menu
        puts "\nPlease enter the number of a brewery for additional information."
        puts "To see a specific city, enter 'city', or enter 'relist' to show results from the state again."
        puts "Otherwise, you can enter 'new search' to search again or 'exit' to quit."

        input = nil
        input = gets.strip.downcase

        if (input.to_i > 0) && (input.to_i <= @last_search.size) #specific to a valid brewery selection
            brewery = @last_search[input.to_i - 1]  #uses @last_search to determine if user is at state or city level and to present the correct brewery and options

            #checks to ensure the profile for the brewery being checked has not been scraped already
            brewery.address != nil ? brewery : BrewerySearch::Scraper.scrape_profile(brewery) 
        
            #create display card for brewery
            self.ind_brewery_info(brewery)

            options_input = gets.strip.downcase
                #control flow specific to #ind_brewery_info result
                if brewery.instance_variables.any? {|attr| "@#{options_input}" == attr.to_s}
                    Launchy.open("#{brewery.send(options_input)}") {|exception| puts "Attempted to open #{brewery.send(options_input)} but failed due to : #{exception}"}
                    self.menu
                elsif options_input == "menu"
                    self.menu
                elsif options_input == "exit"
                    self.quit
                else
                    puts "Invalid entry received. Returning to menu."
                    self.menu
                end
        elsif input == "relist"
            self.list_breweries(@last_searched_state)
            self.menu
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
        puts "\n*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
        puts "Brewery Name: #{brewery.name}"
        puts "Brewery Address: #{brewery.address != nil ? brewery.address : "N/A"}"
        puts "Brewery Location: #{brewery.city}, #{brewery.state}"
        puts "Brewery Phone #: #{brewery.phone != nil ? brewery.phone : "N/A"}"
        puts "Brewery Type: #{brewery.type != "" ? brewery.type : "N/A" }"
        puts "Brewery Website: #{brewery.website != nil ? brewery.website : "N/A" }"
        puts "Brewery Facebook: #{brewery.facebook != nil ? brewery.facebook : "N/A" }"
        puts "Brewery Twitter: #{brewery.twitter != nil ? brewery.twitter : "N/A" }"
        puts "Brewery Instagram: #{brewery.instagram != nil ? brewery.instagram : "N/A" }"
        puts "Brewery Youtube: #{brewery.youtube != nil ? brewery.youtube  : "N/A" }"
        puts ""
        puts "Brewery Overview: #{brewery.overview.strip}"
        puts "*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*"
        puts "\nYou can say 'Website', 'Facebook', 'Twitter', 'Instagram', or"
        puts "'Youtube' to visit the page. Otherwise say 'menu' if you'd like"
        puts "to return, or 'exit' if you'd like to quit."
    end

    #it will terminate the program if the user so chooses
    def quit
        puts "Thank you for using Brewery Search. Have a great day!"
        exit
    end
end
