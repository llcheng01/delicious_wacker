require 'httparty'
require 'json'
require 'uri'

module DeliciousPostHelper
    class Post
        include HTTParty

        base_uri 'https://api.delicious.com/v1/'
        default_timeout 4

        def initialize(u, p)
            @auth = {username: u, password: p}
        end

        def posts(options={})
            options.merge!({basic_auth: @auth})
            self.class.get('/posts/get', options)
        end

        def recent(options={})
            options.merge!({basic_auth: @auth})
            self.class.get('/posts/recent', options)
        end
    end
end
