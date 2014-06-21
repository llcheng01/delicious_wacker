# spec/spec_helper.rb
require 'rack/test'
require 'capybara'

# require File.expand_path '../../app.rb', __FILE__
require File.expand_path '../../main.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
    include Rack::Test::Methods
    def app() Sinatra::Application end
end

RSpec.configure {|c| c.include RSpecMixin}
