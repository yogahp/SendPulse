$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dotenv'
require 'json'
Dotenv.load

require 'sendpulse/api'
require 'sendpulse/smtp'
require 'sendpulse/mailing_list'
