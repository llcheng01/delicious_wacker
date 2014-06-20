# app.rb
require 'sinatra'

get '/' do
    "Hello World #{params[:name]}".strip
end
