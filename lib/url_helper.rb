# url_helper.rb
require 'net/http'

module UrlHelper
    def url_exist?(url_string)
        url = URI.parse(url_string)
        req = Net::HTTP.new(url.host, url.port)
        req.use_ssl = (url.scheme == 'https')
        path = url.path unless url.path.nil?
        res = req.request_head(path || '/')
        if res.kind_of?(Net::HTTPRedirection)
            url_exist?(res['location'])
        else
            res.code[0] != "4"
        end
    rescue Errno::ENOENT
        false
    end
end
