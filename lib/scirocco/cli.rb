require 'scirocco'
require 'thor'

module Scirocco
  class CLI < Thor
    desc "run-test", "run test"
    def run_test(param)
      say(param, :red)
    end
  end
end
