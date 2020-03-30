require 'webmock/cucumber'

WebMock.stub_request(:post, "https://requestb.in/14rl2ir1").
        to_return(status: 200, body: "", headers: {})
