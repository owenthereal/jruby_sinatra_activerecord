$LOAD_PATH.unshift 'lib'

APP_ENV  = ENV["RACK_ENV"] ||= "development" unless defined?(APP_ENV)
APP_ROOT = File.expand_path('../..', __FILE__) unless defined?(APP_ROOT)

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, APP_ENV)

require 'sinatra/reloader' if APP_ENV == 'development'
require 'active_record'

require File.join(APP_ROOT, 'lib', 'app')
require File.join(APP_ROOT, 'config', 'database')
