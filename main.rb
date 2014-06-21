# main.rb
require 'sinatra'
require 'json'
require './helpers/init'

require_relative 'lib/delicious_api_helper'

helpers do
    include DeliciousApiHelper
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
    #begin
        @result = DeliciousApiHelper::Link.new("frogmonkey77").get_public_links()
    # rescue RuntimeError => @exception
    #     return erb %{retrieving links failed: <%=h @exception.message %>}
    # end
    if @result.empty?
        logger.info "result is empty"
    else
        logger.info "Result: #{@result.inspect}"
    end
    format_response(@result, request.accept)
end
