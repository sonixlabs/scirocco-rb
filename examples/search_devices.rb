require 'scirocco'

API_KEY = ENV['SCIROCCO_API_KEY']
PROJECT_ID = ENV['SCIROCCO_PROJECT_ID']

client = Scirocco::Client.new(API_KEY)
devices = client.devices(PROJECT_ID, {:status => "available"})["devices"]
pp devices
