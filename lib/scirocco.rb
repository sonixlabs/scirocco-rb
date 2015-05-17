require 'open-uri'
require 'json'
require 'net/https'
require 'rest-client'
require 'scirocco/version'
require 'scirocco/cli'
require 'scirocco/client'
require 'scirocco/constants'

module Scirocco
  HOSTNAME = 'www.scirocco-cloud.com'
  API_VERSION  = 'v1'

  class SciroccoTestError < StandardError; end
end
