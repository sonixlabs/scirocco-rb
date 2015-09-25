require 'thor'
require 'pp'

module Scirocco
  class CLI < Thor
    class_option :api_key, :required => ARGV.size > 0 && ARGV[0] != 'help'
    class_option :scheme
    class_option :host
    class_option :port

    desc "projects", "Print list of projects"
    def projects
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.projects()
    end

    desc "tests", "Print list of tests associated with the given project_id"
    option :project_id, :required => true
    def tests
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.tests(options[:project_id])
    end

    desc "run_test", "Runs the test on the device"
    option :test_class_id, :required => true
    option :device_id, :required => true
    option :poll, :type => :boolean
    def run_test
      client = Scirocco::Client.new(options[:api_key], options)
      test_job = client.run_test(options[:test_class_id], options[:device_id])["test_job"]
      puts "* test_job:"
      pp test_job
      if options[:poll]
        test_status = client.poll_test_result(test_job["test_job_id"])
        if test_status["status"] == "passed"
          puts "**** PASSED ****"
          pp test_status
        elsif test_status["status"] == "failed"
          puts "**** FAILED ****"
          pp test_status
          raise SciroccoTestError.new(test_status["result"])
        end
      end
    end

    desc "check_test", "Check the test result"
    option :test_job_id, :required => true
    def check_test
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.check_test(options[:test_job_id])
    end

    desc "abort_test", "Abort the booked test job"
    option :test_job_id, :required => true
    def abort_test
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.abort_test(options[:test_job_id])
    end

    desc "abort_all", "Abort the all booked test jobs"
    def abort_all
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.abort_all
    end

    desc "devices", "Print list of devices"
    option :project_id, :required => true
    option :os
    option :os_version
    option :carrier
    option :model
    option :country
    option :status
    def devices
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.devices(options[:project_id], options)
    end

    desc "get_device_id", "Get device id"
    option :project_id, :required => true
    option :os
    option :os_version
    option :carrier
    option :model
    option :country
    option :status
    def get_device_id
      client = Scirocco::Client.new(options[:api_key], options)
      devices = client.devices(options[:project_id], options)["devices"]
      if devices.length > 0
        print devices[0]["device_id"]
      else
        print ""
      end
    end

    desc "apps", "Print list of apps"
    option :project_id, :required => true
    def apps
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.apps(options[:project_id])
    end

    desc "upload_app", "Upload app"
    option :project_id, :required => true
    option :app_path, :required => true
    def upload_app
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.upload_app(options[:project_id], options[:app_path])
    end

  end
end
