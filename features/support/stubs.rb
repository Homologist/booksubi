require 'webmock/cucumber'

WebMock.stub_request(:put, /https:\/\/books-ubi\.s3\.eu-west-2\.amazonaws.com.*/).to_return(status: 200, body: "", headers: {})
WebMock.stub_request(:post, "https://requestb.in/14rl2ir1").
        with(
          body: {"s3_url"=>/https:\/\/books-ubi\.s3\.eu-west-2\.amazonaws\.com\/.*/},
          headers: {
      	  'Accept'=>'*/*',
      	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      	  'Content-Type'=>'application/x-www-form-urlencoded',
      	  'Host'=>'requestb.in',
      	  'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: "", headers: {})
