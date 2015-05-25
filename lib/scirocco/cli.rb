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

    desc "tests <PROJECT_ID>", "Print list of tests associated with the given project_id"
    def tests(project_id)
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.tests(project_id)
    end

    option :poll, :type => :boolean
    desc "run_test <TEST_CLASS_ID> <DEVICE_ID>", "Runs the test on the device"
    def run_test(test_class_id, device_id)
      client = Scirocco::Client.new(options[:api_key], options)
      test_job = client.run_test(test_class_id, device_id)["test_job"]
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

    desc "check_test <TEST_JOB_ID>", "Check the test result"
    def check_test(test_job_id)
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.check_test(test_job_id)
    end

    desc "devices <PROJECT_ID>", "Print list of devices"
    def devices(project_id)
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.devices(project_id)
    end

    desc "apps <PROJECT_ID>", "Print list of apps"
    def apps(project_id)
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.apps(project_id)
    end

    desc "upload_app <PROJECT_ID> <APP_PATH>", "Upload app"
    def upload_app(project_id, app_path)
      client = Scirocco::Client.new(options[:api_key], options)
      pp client.upload_app(project_id, app_path)
    end

  end
end
