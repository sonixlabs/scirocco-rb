# SciroccoCloud Client

The official Ruby client for the SciroccoCloud API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scirocco'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scirocco

## Running Tests

    $ scirocco run_test $TEST_CLASS_ID $DEVICE_ID --api-key $API_KEY --poll

## Jenkins Integration

In Jenkins create a new Execute Shell build step as pictured below.

![Jenkins Integration](https://raw.github.com/sonixlabs/scirocco-rb/master/assets/jenkins.png)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec scirocco` to use the code located in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/scirocco/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
