require 'spec_helper'

describe "BrewerySearch::Brewery" do
    describe "#initialize" do
        it 'instantiates a new object of the Brewery class' do
            # brew_1 = BrewerySearch::Brewery.new("Deep Ellum Brewing Co.", "Dallas", "TX", "2823 St. Louis St.", "deepellumbrewing.com", "www.facebook.com/deepellumbrewing", "www.twitter.com/deepellumbrewing", "www.instagram.com/deepellumbrewing")
            # allow($stdout).to receive(:puts)
            
            # expect(brew_1.name).to eq("Deep Ellum Brewing Co.")

            # expect(brew_1.city).to eq("Dallas")

            # expect(brew_1.state).to eq("TX")

            # expect(brew_1.address).to eq("2823 St. Louis St.")

            # expect(brew_1.url).to eq("deepellumbrewing.com")

            # expect(brew_1.facebook_link).to eq("www.facebook.com/deepellumbrewing")

            # expect(brew_1.twitter_link).to eq("www.twitter.com/deepellumbrewing")

            # expect(brew_1.insta_link).to eq("www.instagram.com/deepellumbrewing")

            test_hash = {:name=>"Deep Ellum Brewing Co.", :city=>"Dallas", :state=>"TX", :address=>"2823 St. LouisSt.", :url=>"deepellumbrewing.com", :facebook_link=>"www.facebook.com/deepellumbrewing", :twitter_link=>"www.twitter.com/deepellumbrewing", :insta_link=>"www.instagram.com/deepellumbrewing"}
            
            expect(BrewerySearch::Brewery.new(test_hash).name).to eq("Deep Ellum Brewing Co.")
        end
    end

    # describe "#create_from_hash" do
    #     let!(:hash) {{:name=>"Deep Ellum Brewing Co.", :city=>"Dallas", :state=>"TX", :address=>"2823 St. Louis St.", :url=>"deepellumbrewing.com", :facebook_link=>"www.facebook.com/deepellumbrewing", :twitter_link=>"www.twitter.com/deepellumbrewing", :insta_link=>"www.instagram.com/deepellumbrewing"}}
    #     it 'instantiates a new Brewery object from a hash passed to it' do
    #         # test = BrewerySearch::Brewery.create_from_hash(hash)
    #         expect((a = BrewerySearch::Brewery.new(hash)).name).to eq("Deep Ellum Brewing Co.")
    #         expect(a.name).to eq{"Deep Ellum Brewing Co."}
    #     end
    # end

end
