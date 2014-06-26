# main.rb
require 'sinatra'
require 'json'
require './helpers/init'
require 'cgi'

require_relative 'lib/delicious_api_helper'
require_relative 'lib/delicious_post_helper'
require_relative 'lib/url_helper'

unless USERNAME = ENV['USERNAME']
    raise "You must specify the username env variable"
end
unless PASSWORD = ENV['PASSWORD']
    raise "You must specify the password env variable"
end

helpers do
    include DeliciousApiHelper
    include DeliciousPostHelper
    include UrlHelper
    include Rack::Utils
    alias_method :h, :escape_html
end

# default root to load js and css
get '/' do
    erb :index
end

get '/partials/:name' do
    erb params[:name].to_sym, layout: false
end

get '/api/bookmarks' do
    begin
      @result = DeliciousApiHelper::Link.new("frogmonkey77").get_public_links()
    rescue RuntimeError => @exception
        return erb %{retrieving links failed: <%=h @exception.message %>}
    end
    @result.each_with_index do |r, i|
       status = url_exist?(r['url'])
       logger.info "#{r['url']} => #{status}"
       r['id'] = i.to_i
       r['status'] = status
    end

    if @result.empty?
        logger.info "result is empty"
    else
        logger.info "Result: #{@result.inspect}"
    end
    format_response(@result, request.accept)
end

get '/api/bookmark/:url' do
    # @posts = DeliciousPostHelper::Post.new(USERNAME, PASSWORD).posts(query: {tag: 'ruby'})
    # /api/bookmark/google.com works! Weird!
    url_escape_string = CGI::escape("params[:url]")
    @posts = DeliciousPostHelper::Post.new(USERNAME, PASSWORD).posts(query: {href: url_escape_string})
    # @recent = DeliciousPostHelper::Post.new(USERNAME, PASSWORD).recent
    format_response(@posts, request.accept)
end
