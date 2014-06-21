# config.ru

require 'rubygems'
require 'bundler'
Bundler.require

require './env' if File.exists?('env.rb')
# require File.expand_path(File.dirname(__FILE__) + '/app')
require File.expand_path(File.dirname(__FILE__) + '/main')

run Sinatra::Application
