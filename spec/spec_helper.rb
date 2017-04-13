$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dotenv'
require 'json'
Dotenv.load

require 'sendpulse/api'
require 'sendpulse/smtp_service'
require 'sendpulse/email_service/mailing_list'
