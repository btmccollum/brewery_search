#CLI Controller

class BrewerySearch::CLI

    #launches the CLI and greets the user with a welcome screen, prompts user to enter a state to search
    def start
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
        puts " To begin, please enter the state that you'd like to search: "

        input = nil
        input = gets.strip

        #method to scrape a specific state that matches the users input
        BrewerySearch::Scraper.scrape_from_results(input)

        list_breweries

        self.menu
    end

    #it will return a list of breweries from the state specified by the user, in alphabetical order
    def list_breweries
        # here doc https://www.brewbound.com/breweries
        puts <<-DOC.gsub /^\s*/, ''
            1. (405) Brewing Co -- Norman, OK -- N/A
            2. (512) Brewing Co -- Austin, TX -- N/A
            3. 101 Brewery -- Quilcene, WA -- Brewpub
            4. 101 Ciderhouse -- N/A -- Production - Micro
            5. 101 North Brewing Company -- Petaluma, CA -- Production - Micro
        DOC
    end

    #will return a of breweries in the specified city
    def breweries_by_city(city)

    end

    #it will provide the user with a list of options for the breweries returned by #list_breweries
    #will look to change case/when to an if/else to cut down on amount of code
    def menu
        puts "\nPlease enter the number of a brewery for additional information.\nYou can type 'list' to see the breweries again or 'exit' to quit."
        puts "If you would like to filter by a specific city, please type the name of that city."
        input = nil
        while input != "exit"
            input = gets.strip
            case input
            when "1"
                puts "More info on brewery 1"
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
