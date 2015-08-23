# url-responsetime
Calculates and records the response time for given list of http urls in json format

# Getting Started
## Start by cloning this repo to your local workstation: 
git clone https://github.com/nalinipatel/url-responsetime.git

## Edit the urllist file, add the website urls for which you wish to find site-response time(separated by newline)

## Run the ruby module. See the sample in Testing section below.

# Dependencies
This module has been written/tested in ruby-2.0.0
Please download and setup ruby 2.0.0

# Testing
# Sample Run and Outputs

## > ruby measurelatency.rb
Target URL = http://www.google.com.au, Http Response Code = 200, Response Time(in ms) = 255
Target URL = https://www.facebook.com:443, Http Response Code = 200, Response Time(in ms) = 536
getaddrinfo: nodename nor servname provided, or not known
Target URL = https://twitter.com, Http Response Code = 200, Response Time(in ms) = 1104
Target URL = https://www.google.com.au/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=orange, Http Response Code = 200, Response Time(in ms) = 391

## This should generate the below output file in JSON format:

> cat responsetime.json
[{"url":"http://www.google.com.au","latency_ms":245,"http_responsecode":"200","error_msg":""},{"url":"https://www.facebook.com:443","latency_ms":599,"http_responsecode":"200","error_msg":""},{"url":"http://www.nonexistentsite.com.au/","latency_ms":0,"http_responsecode":"404","error_msg":"getaddrinfo: nodename nor servname provided, or not known"},{"url":"https://twitter.com","latency_ms":1483,"http_responsecode":"200","error_msg":""},{"url":"https://www.google.com.au/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=orange","latency_ms":616,"http_responsecode":"200","error_msg":""}]
