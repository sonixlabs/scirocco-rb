require 'thor'
require 'pp'

module Scirocco
  class CLI < Thor
    #class_option :key, :required => true
    class_option :scheme
    class_option :host
    class_option :port

    desc "run_test", "run test"
    def run_test()
      say(param, :red)
    end

    desc "projects KEY", "print projects"
    def projects(key)
      client = Scirocco::Client.new(key, options)
      pp client.projects()
    end

    desc "tests KEY PROJECT_ID", "print tests"
    def tests(key, project_id)
      client = Scirocco::Client.new(key, options)
      pp client.tests(project_id)
    end

    desc "devices KEY PROJECT_ID", "print devices"
    def devices(key, project_id)
      client = Scirocco::Client.new(key, options)
      pp client.devices(project_id)
    end
  end
end
