strequire 'thor'
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

    desc "tests <PROJECT_ID>", "Print list of tests associated with the given project_id"
    def tests(project_id)
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.tests(project_id)
    end

    desc "run_test <TEST_ID> <DEVICE_ID>", "Runs the test on the device"
    def run_test(test_class_id, device_id)
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.run_test(test_class_id, device_id)
    end

    desc "check_test <TEST_JOB_ID>", "Check the test result"
    def check_test_result(test_class_id, device_id)
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.check_test(test_job_id)
    end

    desc "devices <PROJECT_ID>", "Print list of devices"
    def devices(project_id)
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.devices(project_id)
    end
  end
end
