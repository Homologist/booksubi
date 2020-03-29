require 'webmock/cucumber'

WebMock.stub_request(:put, /https:\/\/books-ubi.s3.eu-west-2.amazonaws.com.*/).to_return(status: 200, body: "", headers: {})
