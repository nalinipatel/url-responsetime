#!/usr/bin/ruby
require 'net/http'
require 'net/https'
require 'uri'
require 'json'

# to_ms(time_in_sec) : It performs following actions:
# Converts seconds to milliseconds
def to_ms(time_in_sec)
  (time_in_sec.to_f * 1000.0).to_i
end

# check_latency(): It performs following actions:
# 1. Reads the list of urls from a file named "urllist"
# 2. Sends http get request and checks the response time for each url
# 3. Writes output in json format in latency.json file
# 4. If the url is malformed/doesn't exist, then error msg is added to json file
# @todo : can be modified to configure file-names instead of using static filenames.

def check_latency()
  hash_arr = []
  begin
    File.open("urllist") do |fileobj|
      fileobj.each_line do |line|
        url_stripped = line.strip
        # Send HTTP GET Request
        begin
          targetURI = URI.parse(url_stripped)
          httpConn = Net::HTTP.new(targetURI.host,targetURI.port)
          httpConn.use_ssl = true if targetURI.scheme == 'https'
          httpConn.verify_mode = OpenSSL::SSL::VERIFY_NONE

          httpReq = Net::HTTP::Get.new(targetURI.request_uri)

          startTime = Time.now
          httpRes = httpConn.request(httpReq) 
          endTime = Time.now
          latency = to_ms(endTime) - to_ms(startTime)

        rescue Exception => connerr
          puts connerr
          hash_arr << {'url'=> url_stripped, 'latency_ms'=> 0, 'http_responsecode'=> "404", 'error_msg' => connerr}
          next
        end

        puts ('Target URL = ' + url_stripped + ', Http Response Code = ' + httpRes.code + ', Response Time(in ms) = '+ latency.to_s)

        # Add the result to hash
        hash_arr << {'url'=> url_stripped, 'latency_ms'=> latency, 'http_responsecode'=> httpRes.code, 'error_msg' => ''}
      end
    end
    File.open("responsetime.json","w+") do |outfile|
      outfile.puts(hash_arr.to_json)
    end
  rescue Exception => err
    puts err
  end
end

check_latency

