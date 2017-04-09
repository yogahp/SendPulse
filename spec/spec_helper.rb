$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dotenv'
require 'json'
Dotenv.load

require 'simplecov'
SimpleCov.start

require 'sendpulse/api'
require 'sendpulse/smtp'
