#CLI Controller

class BrewerySearch::CLI

    def welcome   
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
    end

    def call_options
        welcome
        start
        list_breweries
        menu
        
        quit
    end

    def start
        input = nil
        puts " To begin, please enter the state that you'd like to search: "
        input = gets.strip
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

    #it will provide the user with a list of options for the breweries returned by #list_breweries
    def menu
        puts "\nPlease enter the number of a brewery for additional information.\nYou can type 'list' to see the breweries again or 'exit' to quit:"
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
            when "list"
                list_breweries
            else
                puts "Invalid entry received. Please type list or exit."
            end
        end
        self.goodbye
    end

    #it will terminate the program if the user so chooses
    def quit
        puts "Thank you for using Brewery Search. Have a great day!"
    end
end
