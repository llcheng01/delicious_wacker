require 'httparty'
require 'json'
require 'uri'

module DeliciousApiHelper
    class Link
        include HTTParty

        base_uri 'http://feeds.delicious.com/v2/'
        default_timeout 4

        def initialize(username)
            @username = username
            @options = {:query => {:count => '25'}}
        end

        def get_public_links
            result = []
            # begin
                resp = self.class.get("/json/" + @username.to_s, @options)
                # resp = self.class.get("/json/" + @username.to_s)
                if resp.success?
                    resp.parsed_response.each do |l|
                        result << {'url' => l['u'], 'desc' => l['d']}
                    end
                end
           #  rescue StandardError, Timeout::Error => @exception
           #      # logger.info "get_public_links fails for username: " + @username.to_sA
           #      raise "Resp: #{resp.inspect} #{@exception.message}"
           #  end
            result
        end
    end
end
