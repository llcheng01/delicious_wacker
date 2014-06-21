# app.rb
require 'sinatra'
require 'oauth2'
require 'json'

enable :sessions
# set :session_secret, '*&i(^B234'

helpers do
    include Rack::Utils
    alias_method :h, :escape_html
end

configure do
    use Rack::Session::Cookie, :secret => Digest::SHA1.hexdigest(rand.to_s)
end

# SCOPES = [
# ].join(' ')

unless D_API_CLIENT = ENV['D_API_CLIENT']
    raise "You must specify the D_API_CLIENT env variable"
end

unless D_API_SECRET = ENV['D_API_SECRET']
    raise "You must specify the D_API_SECRET env variable"
end

def base_url
    default_port = (request.scheme == "http")? 80 : 443
    port = (request.port == default_port) ? "" : ":#{request.port.to_s}"
    "#{request.scheme}://#{request.host}#{port}"
end

def client
    client ||= OAuth2::Client.new(D_API_CLIENT, D_API_SECRET, {
        :site => 'https://delicious.com',
        :authorize_url => "/auth/authorize",
        :token_url => "/auth/token"
    })
end

get '/' do
    # "Hello World #{params[:name]}".strip
    erb :index
end

get "/auth" do
    callback_url = "#{base_url}/oauth2callback"
    # request_token = client.get_request_token(:oauth_callback => callback_url)
    # session[:request_token] = request_token.token
    # session[:request_token_secret] = request_token.secret
    # redirect request_token.authorize_url
    redirect client.auth_code.authorize_url(:redirect_uri => callback_url)
end

get '/oauth2callback' do
    callback_url = "#{base_url}/oauth2callback"
    begin
        puts #{client.auth_code.inspect}
        @token = client.auth_code.get_token(params[:code], :token_method => :post, :redirect_uri => callback_url, :client_id => D_API_CLIENT, :client_secret => D_API_SECRET, :grant_type => "code")
    rescue OAuth2::Error => @exception
        return erb %{oauth2 failed: <%=h @exception.message %>}
    end
    session[:access_token] = @token.token
    @message = "Successfully authenicated with the server"
    @access_token = session[:access_token]
   
    # parsed is handy method on an OAuth2::Response object that will
    # intelligently try and parse the response.body
    @email = @token.get("status").parsed
    erb :success
end

def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/oauth2callback'
    uri.query = nil
    uri.to_s
end
