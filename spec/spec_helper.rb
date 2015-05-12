require 'rspec'
require 'scirocco'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

API_URI = "https://www.scirocco-cloud.com/api/v1"

def mock_device_types_response(access_token)
  url = "#{API_URI}/devices/types/?api_key=#{api_key}"
  response = "{\"meta\": {\"code\": 200, \"request_id\": 475}, \"response\": [
  {\"device_type_id\": 1, \"name\": \"4s\", \"battery\": true, \"brand\": \"iPhone\", \"os_name\": \"iOS\", \"os_version\": \"5.1.1\", \"has_available_device\": false, \"carrier\": null},
  {\"device_type_id\": 2, \"name\": \"4\", \"battery\": true, \"brand\": \"iPhone\", \"os_name\": \"iOS\", \"os_version\": \"5.1.1\", \"has_available_device\": true, \"carrier\": null}]
  }"
  FakeWeb.register_uri(:get, url, :body => response, :status => 200)
end


def mock_access_token_response(token="r895ku94f167udxfukhkbntyclxvwl8sc", ttl=86400)
  url = "#{API_URI}/access_token/generate/"
  response ="{\"meta\": {\"code\": 200, \"request_id\": 123.456}, \"response\": {\"access_token\": \"#{token}\", \"ttl\": #{ttl}}}"
  FakeWeb.register_uri(:post, url, :body => response, :status => 200)
end

def mock_application_upload_response(application_id="qxp58i5tbaosgbq8nagosfkf490gs7spd")
  url = "#{API_URI}/apps/upload/"
  response = "{\"meta\": {\"code\": 200, \"request_id\": 123}, \"response\": {\"name\": \"cisimple.app.zip\", \"test_type\": null, \"uploaded_on\": \"2013-03-13T21:39:59Z\", \"source_type\": \"url\", \"ttl\": 86400, \"id\": \"#{application_id}\", \"size\": 404423}}"
  FakeWeb.register_uri(:post, url, :body => response, :status => 200)
end

def mock_test_upload_response(test_id="eh4x44nspdqcsva7v2nvabjesvoqvcn89", test_type="ocunit")
  url = "#{API_URI}/tests/upload/"
  response = "{\"meta\": {\"code\": 200, \"request_id\": 452}, \"response\": {\"name\": \"cisimpleTests.octest.zip\", \"test_type\": \"#{test_type}\", \"uploaded_on\": \"2013-03-13T22:12:50Z\", \"source_type\": \"url\", \"ttl\": 86400, \"id\": \"#{test_id}\", \"size\": 7764}}"
  FakeWeb.register_uri(:post, url, :body => response, :status => 200)
end

def mock_run_test_response(test_run_id=1)
  url = "#{API_URI}/tests/run/"
  response = "{\"meta\": {\"code\": 200, \"request_id\": 123}, \"response\": { \"test_run_id\": #{test_run_id} }}"
  FakeWeb.register_uri(:post, url, :body => response, :status => 200)
end

def mock_upload_device_conditions_response
  url = "#{API_URI}/config/upload/"
  response = "{\"meta\": {\"code\": 200, \"request_id\": 123}, \"response\": { }}"
  FakeWeb.register_uri(:post, url, :body => response, :status => 200)
end

def mock_monitor_test_response(access_token, test_run_id=1, status="complete")
  url = "#{API_URI}/tests/check/?access_token=#{access_token}&test_run_id=#{test_run_id}"
  response = "{\"meta\": {\"code\": 200, \"request_id\": 123}, \"response\": { \"status\": \"#{status}\" }}"
  FakeWeb.register_uri(:get, url, :body => response, :status => 200)
end

#def mock_device_types_response(access_token)
#  url = "#{API_URI}/devices/list/?access_token=#{access_token}"
#  response = "{\"meta\": {\"code\": 200, \"request_id\": 475}, \"response\": [{\"device_type_id\": 1, \"name\": \"4s\", \"battery\": true, \"brand\": \"iPhone\", \"os_name\": \"iOS\", \"os_version\": \"5.1.1\", \"has_available_device\": false, \"carrier\": null}, {\"device_type_id\": 2, \"name\": \"4\", \"battery\": true, \"brand\": \"iPhone\", \"os_name\": \"iOS\", \"os_version\": \"5.1.1\", \"has_available_device\": true, \"carrier\": null}]}"
#  FakeWeb.register_uri(:get, url, :body => response, :status => 200)
#end


def mock_network_conditions_response(access_token)
  url = "#{API_URI}/devices/config/networks/list/?access_token=#{access_token}"
  response = "{\"meta\": {\"code\": 200, \"request_id\": 9673}, \"response\": [
    {\"network_id\": 29, \"network_group\": \"AT&T\", \"network_name\": \"4G_LTE\"},
    {\"network_id\": 16, \"network_group\": \"AT&T\", \"network_name\": \"3G_4_Bars\"},
    {\"network_id\": 17, \"network_group\": \"AT&T\", \"network_name\": \"3G_3_Bars\"},
    {\"network_id\": 18, \"network_group\": \"AT&T\", \"network_name\": \"3G_2_Bars\"},
    {\"network_id\": 19, \"network_group\": \"AT&T\", \"network_name\": \"3G_1_Bar\"}]}"
  FakeWeb.register_uri(:get, url, :body => response, :status => 200)
end
