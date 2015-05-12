require 'spec_helper'
require 'fake_web'
require 'timecop'

describe Scirocco do

  let (:key) { "7ks6hmigudkbx3uuipgmqllhcoqmxf5mq" }

  before do
    FakeWeb.allow_net_connect = false
  end

  describe "When configuring an Scirocco Client" do

    it "should correctly configure the key" do
      client = Scirocco::Client.new(key)
      client.key.should == key
    end

    it "should correctly configure connection options" do
      options = {
        scheme: "http",
        host: "staging.scirocco.com",
        port: 80,
        request_timeout: 5,
        open_timeout: 5
      }

      client = Scirocco::Client.new(key, options)
      client.scheme.should == options[:scheme]
      client.host.should == options[:host]
      client.port.should == options[:port]
      client.request_timeout.should == options[:request_timeout]
      client.open_timeout.should == options[:open_timeout]
    end

  end

  describe "When using an Scirocco Client" do

    let (:client) { Scirocco::Client.new(key) }
    let (:token) { "e8k3jd64gfrgbtqrunaipx9pl34xkao6c" }
    let (:ttl) { 86400 }
    let (:application_id) { "lvq2g2y6hn0sr36k9i9mrcochh49tbww3" }
    let (:test_id) { "d9yovkaekgg29c3d2nr4guhfppe0jewra" }
    let (:test_type) { "ocunit" }
    let (:device_type) { 1 }
    let (:device_id) { 10 }
    let (:app_url) { "https://www.cisimple.com/builds/1/build_steps/1/artifacts/cisimple.app.zip" }
    let (:test_url) { "https://www.cisimple.com/builds/1/build_steps/1/artifacts/cisimple.octest.zip" }

    before do
      mock_access_token_response(token, ttl)
      mock_application_upload_response(application_id)
      mock_test_upload_response(test_id, test_type)
      mock_run_test_response
      mock_monitor_test_response(token)
      mock_upload_device_conditions_response
      mock_device_types_response(token)
      mock_network_conditions_response(token)
    end

    it "should successfully retrieve an access token" do
      client.access_token.should == token
    end

    it "should cache access tokens" do
      client.access_token
      FakeWeb.clean_registry
      mock_access_token_response
      client.access_token.should == token
    end

    it "should retrieve a new access token when the current one has expired" do
      client.access_token
      FakeWeb.clean_registry
      expected_token = "2hmiusynojjtgxsnd6eqdop1lreeua56i"
      mock_access_token_response(expected_token)
      Timecop.travel(Time.now + ttl + 1)
      client.access_token.should == expected_token
    end

    it "should successfully upload an application from a url" do
      response = client.upload_app_from_url(app_url)
      response["id"].should == application_id
    end

    it "should successfully upload a test from a url" do
      response = client.upload_test_from_url(test_url, test_type)
      response["id"].should == test_id
      response["test_type"].should == test_type
    end

    it "should successfully start a test on a device" do
      test_run_id = 5
      mock_run_test_response(test_run_id)
      response = client.run_test(device_id, application_id, test_id)
      response["test_run_id"].should == test_run_id
    end

    it "should successfully monitor a test run" do
      test_run_id = 5
      mock_monitor_test_response(token, test_run_id)
      response = client.monitor_test(test_run_id)
      response["status"].should == "complete"
    end

    it "should successfully retrieve the list of device types" do
      response = client.device_types
      response.count.should == 2
    end

    it "should successfully retrieve the list of network conditions" do
      client.network_conditions.count.should == 5
    end

    it "should be able to execute a test end to end" do
      device_type = client.device_types.first["id"]
      app_id = client.upload_app_from_url(app_url)["id"]
      test_id = client.upload_test_from_url(test_url, test_type)["id"]
      client.upload_device_conditions(test_id, {:memory => 300, :network => 5})
      test_run_id = client.run_test(device_type, app_id, test_id)["test_run_id"]
      client.monitor_test(test_run_id)
    end

  end

end
