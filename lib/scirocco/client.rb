require 'pp'
require_relative 'hash_ex'

module Scirocco
  class Client
    attr_accessor :scheme, :host, :port, :version, :api_key, :request_timeout, :open_timeout, :last_request

    API_POLL_SEC = 15  # test result polled every poll seconds

    def initialize(api_key, options={})
      @api_key = api_key
      @scheme, @host, @port, @version, @request_timeout, @open_timeout = {
        scheme: "https",
        host: HOSTNAME,
        port: 443,
        version: API_VERSION,
        request_timeout: 600,
        open_timeout: 10
      }.merge(options.symbolize_keys).values
    end

    def projects
      url = build_url("projects")
      get(url)["projects"]
    end

    ##############
    ## Device API
    ##############

    def devices(project_id)
      url = build_url("devices")
      get(url, {:project_id => project_id})
    end


    ############
    ## Test API
    ############

    def tests(project_id)
      url = build_url("tests")
      get(url, {:project_id => project_id})["tests"]
    end

    def run_test(test_class_id, device_id)
      url = build_url("tests", "run")
      data = {
        :api_key => @api_key,
        :test_class_id => test_class_id,
        :device_id => device_id
      }

      post(url, data)["test_job"]
    end

    # Checks for when test completes
    def poll_test_result(test_job_id)
      status = nil
      runtime = 0
      while !['passed', 'failed'].include?(status)
        sleep(API_POLL_SEC)
        test_status = check_test(test_job_id)["test_status"]
        status = test_status["status"]
        if ['passed', 'failed'].include?(status)
          return test_status
        else
          puts "polling...   status: #{status}"
        end
      end

    end

    def check_test(test_job_id)
      url = build_url("tests", "check")
      params = { test_job_id: test_job_id }
      get(url, params)
    end

    private

    def build_url(type, resource=nil)
      @scheme + "://" + [@host + ":" + @port.to_s, "api", @version, type, resource].compact.join("/") + "/"
    end

    def get(url, params={})
      @last_request = {
        url: url,
        request: params
      }

      query_string_params = params.collect{ |p| "&#{p[0].to_s}=#{p[1].to_s}" }.join
      #p "#{url}?api_key=#{@api_key}#{query_string_params}"

      #begin
        response = RestClient::Request.execute(:method => :get, :url => "#{url}?api_key=#{@api_key}#{query_string_params}", :timeout => @request_timeout, :open_timeout => @open_timeout)
        @last_request[:response] = response
        JSON.parse(response)
      #rescue => err
      #  pp err
      #  if err.response
      #    raise JSON.parse(err.response)["error"]
      #  else
      #    raise err
      #  end
      #end
    end

    def post(url, data, capture_request=true)
      if capture_request
        @last_request = {
          url: url,
          request: data
        }
      end

      result = RestClient::Request.execute(:method => :post, :url => url, :payload => data, :timeout => @request_timeout, :open_timeout => @open_timeout)
      @last_request[:response] = result if capture_request

      JSON.parse(result)
    end
  end
end
