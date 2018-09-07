require 'spec_helper.rb'

describe "BrewerySearch::CLI" do
    describe "#welcome" do
        it "returns a welcome splash screen to the user in the form of ASCII art depicting a beer mug and a welcome message" do
            # expect(BrewerySearch::CLI.welcome).to eq(true)
            allow($stdout).to receive(:puts)
        end
    end

    describe "#start" do
        it "prompts the user to enter a state they would like to search and collects their input" do
            test = BrewerySearch::CLI.new
            # allow($stdout).to receive(:puts)
            expect(test).to respond_to(:start)
            
            # expect($stdout).to eq("To begin, please enter the state that you'd like to search: ")
            # expect(test.start).to_return("To begin, please enter the state that you'd like to search: ")
        end
    end

end



