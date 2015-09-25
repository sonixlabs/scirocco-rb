# SciroccoCloud Client

The official Ruby client for the [SciroccoCloud](http://www.scirocco-cloud.com/) API.

## Document

[Scirocco Cloud API Docs](https://www.scirocco-cloud.com/swagger)

## Installation

Add this line to your application's Gemfile:

    gem 'scirocco', '0.1.4'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scirocco -v 0.1.4

## Upload app

    $ scirocco upload_app --project-id=$PROJECT_ID --app-path=$APP_PATH --api-key=$API_KEY


## Search device

    $ scirocco devices --project-id=$PROJECT_ID --status=available --api-key=$API_KEY

## Running tests

    $ scirocco run_test --test-class-id=$TEST_CLASS_ID --device-id=$DEVICE_ID --api-key=$API_KEY --poll

## Abort the all booked test jobs

    $ scirocco abort_all --api-key=$API_KEY --poll

## Jenkins Integration

* In Jenkins, set up a new task.
* In the "Execute shell" section, add the following:

~~~
# Configuration
API_KEY=XXXXX
PROJECT_ID=XXX
APP_PATH=./MainActivity.apk
TEST_CLASS_ID=XXX

# Set available device id
DEVICE_ID=`scirocco get_device_id --project-id=$PROJECT_ID --status=available --api-key=$API_KEY`
if [ -n "$DEVICE_ID" ]; then
  # When available device is not found, set not available device id
  DEVICE_ID=`scirocco get_device_id --project-id=$PROJECT_ID --api-key=$API_KEY`
fi

# Upload apk
scirocco upload_app --project-id=$PROJECT_ID --app-path=$APP_PATH --api-key=$API_KEY

# Get device_id
scirocco get_device_id --project-id=$PROJECT_ID --status=available --api-key=$API_KEY

# Do the test
scirocco run_test --test-class-id=$TEST_CLASS_ID --device-id=$DEVICE_ID --poll --api-key=$API_KEY
~~~

* Save the task.
* Execute the task and check for the console output.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec scirocco` to use the code located in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/scirocco/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
