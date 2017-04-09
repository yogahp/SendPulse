[![Build Status](https://travis-ci.org/yogahp/SendPulse.svg?branch=master)](https://travis-ci.org/yogahp/SendPulse)

# SendPulse

Ruby client for [SendPulse](https://sendpulse.com/)

## Usage

### SMTP
#### Send Email

```ruby
require 'sendpulse/smtp'

email = {
  html: '<html><body><h1>HTML</h1></body></html>',
  text: 'Text',
  subject: 'Subject',
  from: {
    name: 'Sender Name',
    email: 'sender@example.com'
  },
  to: [
    {
      name: 'Receiver Name',
      email: 'receiver@example.com'
    }
  ]
}

sendpulse_smtp = SendPulse::Smtp.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_smtp.send_email(email)
```

#### Retrieve Emails 

```ruby
require 'sendpulse/smtp'

sendpulse_smtp = SendPulse::Smtp.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_smtp.retrieve_emails
```

[Here](https://sendpulse.com/integrations/api) is SendPulse API specification.

## Contributing

1. Fork it ( https://github.com/yogahp/SendPulse/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
