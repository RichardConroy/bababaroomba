# Bababaroomba

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/bababaroomba`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bababaroomba'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bababaroomba

## Design notes

This is a simple exercise to simulate how a domestic cleaning robot would navigate a grid room to clean up spots of dirt.

The Bababaroomba bot starts at the origin point, which is the bottom left of room, and navigates using NSEW directions only to the first dirtpatch, where it instantly cleans it, and then returns to the origin before starting over to clean the next patch and so on.

Whatever algorithm is used, you must print out the sequence of moves as it travels to its target and returns to the origin.


Parked at origin:
```
##########
#........#
#........#
#......~.#
#........#
#B.......#
##########
```

Traveling to dirt:
```
##########
#........#
#........#
#^>>>>>~.#
#^.......#
#B.......#
##########

NNEEEEEE (clean)
```

```
##########
#........#
#........#
#......B.#
#......v.#
#O<<<<<v.#
##########

SSWWWWWW (origin)
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bababaroomba. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/bababaroomba/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Bababaroomba project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/bababaroomba/blob/master/CODE_OF_CONDUCT.md).


