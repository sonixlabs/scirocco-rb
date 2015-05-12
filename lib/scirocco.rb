require 'open-uri'
require 'json'
require 'net/https'
require 'rest-client'
require 'scirocco/version'
require 'scirocco/cli'
require 'scirocco/client'

module Scirocco
  HOSTNAME = 'www.scirocco-cloud.com'
  API_VERSION  = 'v1'
end
