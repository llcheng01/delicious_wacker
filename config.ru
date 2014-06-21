# config.ru

require 'rubygems'
require 'bundler'
Bundler.require

require './env' if File.exists?('env.rb')
require File.expand_path(File.dirname(__FILE__) + '/app')

run Sinatra::Application
