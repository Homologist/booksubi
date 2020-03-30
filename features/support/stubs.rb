require 'webmock/cucumber'

WebMock.stub_request(:put, /https:\/\/books-ubi\.s3\.eu-west-2\.amazonaws.com.*/).to_return(status: 200, body: "", headers: {})
WebMock.stub_request(:post, "https://requestb.in/14rl2ir1").
        to_return(status: 200, body: "", headers: {})
