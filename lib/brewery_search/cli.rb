#CLI Controller

class BrewerySearch::CLI

    VALID_STATES = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "TN", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    last_searched_state = nil

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

        puts " To begin, please enter the state that you'd like to search: "
        
        input = gets.strip
        @last_searched_state = input
        
            if VALID_STATES.include?(input)
                list_breweries(input)
            else 
                puts "Invalid entry, please enter a valid state."
            end

        self.menu
                
    end

    #it will return a list of breweries from the state specified by the user, in alphabetical order
    def list_breweries(input)
        BrewerySearch::Brewery.create_from_state_scrape(input)

        state_listing = BrewerySearch::Brewery.all.select {|x| x.state == input}

        number = 0
        
        puts "Displaying results:"
        while number < state_listing.count
            puts "   #{number + 1}. #{state_listing[number].name} -- #{state_listing[number].city}, #{state_listing[number].state} -- #{state_listing[number].type != "" ? state_listing[number].type : "N/A" }"
            number += 1
        end
    end

    #will return a of breweries in the specified city
    def breweries_by_city
        input = nil

        puts "Please enter the name of the city you would like to filter by:"
        input = gets.strip

        number = 0
        
        state_listing = BrewerySearch::Brewery.all.select {|x| x.state == @last_searched_state}
        city_listing = state_listing.select {|brewery| brewery.city == input && brewery.state == @last_searched_state}
        
        puts "Displaying results:"
        while number < city_listing.count
            puts "   #{number + 1}. #{city_listing[number].name} -- #{city_listing[number].city}, #{city_listing[number].state} -- #{city_listing[number].type != "" ? city_listing[number].type : "N/A" }"
            number += 1
        end
        
        self.menu
    end

    #it will provide the user with a list of options for the breweries returned by #list_breweries
    #will look to change case/when to an if/else to cut down on amount of code
    def menu
        puts "\nPlease enter the number of a brewery for additional information.\nYou can type 'list' to see the breweries again or 'exit' to quit."
        puts "If you would like to filter by a specific city, please type 'city'."
        input = nil
        while input != "exit"
            input = gets.strip
            case input
            when "1"
                BrewerySearch::Brewery
            when "2" 
                puts "More info on brewery 2"
            when "3"
                puts "more info on brewery 3"
            when "4"
                puts "more info on brewery 4"
            when "5"
                puts "more info on brewery 5"
            when "6"
                puts "more info on brewery 5"
            when "7"
                puts "more info on brewery 5"
            when "8"
                puts "more info on brewery 5"
            when "8"
                puts "more info on brewery 5"
            when "10"
                puts "more info on brewery 5"
            when "11"
                puts "more info on brewery 5"
            when "12"
                puts "more info on brewery 5"
            when "13"
                puts "more info on brewery 5"
            when "14"
                puts "more info on brewery 5"
            when "15"
                puts "more info on brewery 5"
            when "16"
                puts "more info on brewery 5"
            when "17"
                puts "more info on brewery 5"
            when "18"
                puts "more info on brewery 5"
            when "19"
                puts "more info on brewery 5"
            when "20"
                puts "more info on brewery 5"
            when "city"
                breweries_by_city
            when "list"
                list_breweries
            else
                puts "Invalid entry received. Please type list or exit."
            end
        end
        self.quit
    end

    #it will terminate the program if the user so chooses
    def quit
        puts "Thank you for using Brewery Search. Have a great day!"
    end
end
