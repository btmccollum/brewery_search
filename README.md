# BrewerySearch

BrewerySearch provides a CLI that allows a user to navigate BrewBound's brewery database and retrieve additional information such as contact information, social media links, general overview, and more.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'brewery_search'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brewery_search

## Usage

Type the following to get started:

    $ brewery-search

A user will be greeted with a welcome screen. Follow the on-screen prompts to continue. Users will have the ability to search by state abbreviations. 

A user will be presented with a list of all registered breweries in that state. A user can call 

    $ city 

to receive a prompt to filter by a specific city, otherwise they can select the number of any brewery for more information.

To navigate back to the state results, a user can enter:

    $ relist

Additional commands from the menu include:
    
    $ new search
    $ exit

New search will bring the user back to the beginning to search for a different state. Exit will quit the program.

When viewing additional information for any brewery, a user will be able to do any of the following commands (if that information is made available) to either launch the corresponding page in the user's default browser, return to the menu, or exit the program:
            
    $ website
    $ facebook
    $ twitter
    $ instagram
    $ menu
    $ exit

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/brewery_search. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BrewerySearch project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/brewery_search/blob/master/CODE_OF_CONDUCT.md).
