# Gelatin: A Jump Consistent Hash Ruby Gem

[![Build Status](https://travis-ci.org/eduardordm/gelatin.svg?branch=master)](https://travis-ci.org/eduardordm/gelatin)

This gem exposes the Google's consistent hash algorithm to ruby. It uses the
original, mostly unmodified, implementation as described by
["A Fast, Minimal Memory, Consistent Hash Algorithm"](http://arxiv.org/abs/1406.2294).

You can use this gem as a consistent hasher or to create a ring of servers like the ones used in
Amazon DynamoDB, Cassandra, etc. You could use it as some sort of novel cluster implementation also.
It will evenly distribute your clients among the servers and remap them when the number of nodes changes.

It containst no collision detection if you plan to use this as the main hasher for object storage, you might
need add aditional steps in your underlying storage implementation.

The performance is good: In a ring of 1.8mi servers and 2mi clients it returned the desired server within < 0.01 ms
on my 4 year old laptop. As long as Array#[] stays O(1) you should be fine.

"Google has not applied for patent protection for this algorithm, and, as of this writing, has no
plans to. Rather, it wishes to contribute this algorithm to the community."


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gelatin'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gelatin

## Usage

If you need just a simple hasher:

```ruby
require 'jch'

key = rand(2**32..2**64-1)

# The hash method takes two BIGNUMs.
# the first is the key to which you are trying to find a node to.
# The second is the quantity of available nodes.
my_node = hash(key, 1000000)
```

If you are using this as a Server Ring (main purpose of this gem):

```ruby
sh = Gelatin::Ring.new
(1...254).each do |i|
  sh.add Gelatin::Node.new("192.168.0.#{i}")
end
puts sh.get(::Zlib::crc32("s3.amazon.com")) # returns the server for this key
```

You might use the same hasher to hash long strings like file paths, but you need to split the string into 64bit chunks.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gelatin.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

