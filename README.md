# Bababaroomba

Modelling the pathfinding operation of a room cleaning robot.

## Installation

Developed with Ruby 2.6.6 but in practice should be insensitive to a lot of ruby versions.

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

run `$ exe/bababaroomba` to execute a shell command with a basic square grid with randomly placed dirt

or `$ exe/bababaroomba WIDTH HEIGHT DIRT` to customise the grid.

e.g.

```
$ exe/bababaroomba 5 3 2
.....
.~...
@~...

Looking for dirt ....
.... dirt found!
NNES

Moving dirt bot along path

.....
.@...
.~...

Cleaning dirt

Retracing steps back to origin
NWSS


.....
.....
@~...

.....
.....
@~...

Looking for dirt ....
.... dirt found!
NNESS

Moving dirt bot along path

.....
.....
.@...

Cleaning dirt

Retracing steps back to origin
NNWSS


.....
.....
@....

```

The algorithm isn't particularly clever - it simply builds a path where it takes the first neighbouring option when there are multiple choices. In practice this will mean the order in which `Neighbours.call` returns the adjacent tiles matters. With a regular rectangular grid and no obstructions this means that the bot will take a snake like path:

```
....    ^>..
..~.    ^v~.
....    ^v^.
@...    @v>.

```





## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Bababaroomba project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/bababaroomba/blob/master/CODE_OF_CONDUCT.md).


