 # Heroku Redis Cloud config
 # https://devcenter.heroku.com/articles/rediscloud
 if ENV["REDIS_URL"]
     uri = URI.parse(ENV["REDIS_URL"])
     $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
 end
