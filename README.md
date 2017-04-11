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

### Mailing List
#### Creating a mailing list

```ruby
require 'sendpulse/mailing_list'

sendpulse_mailinglist = SendPulse::MailingList.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_mailinglist.create("Mailing List Title")
```

#### Editing a mailing list

```ruby
require 'sendpulse/mailing_list'

sendpulse_mailinglist = SendPulse::MailingList.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_mailinglist.update({ id: id, name: "New mailing list name" })
```

#### Retrieving a list of mailing list

```ruby
require 'sendpulse/mailing_list'

sendpulse_mailinglist = SendPulse::MailingList.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_mailinglist.list({ limit: 10, offset: 10 })
```

#### Retrieving mailing list information

```ruby
require 'sendpulse/mailing_list'

sendpulse_mailinglist = SendPulse::MailingList.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_mailinglist.get(mailinglist_id)
```

#### Retrieving a list of emails from a mailing list

```ruby
require 'sendpulse/mailing_list'

sendpulse_mailinglist = SendPulse::MailingList.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_mailinglist.get_emails(mailinglist_id)
```

#### Adding emails to a mailing list

```ruby
require 'sendpulse/mailing_list'

sendpulse_mailinglist = SendPulse::MailingList.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_mailinglist.add_emails(
  {
    id: id,
    emails: [
      {
        "email": "test1@gmail.com",
        "variables": {
          "variable1": "value1",
          "variable2": "value2"
        }
      },
      {
        "email": "test1@gmail.com",
        "variables": {
          "variable1": "value1",
          "variable2": "value2"
        }
      }
    ]
  }
)
```

#### Deleting emails from a mailing list

```ruby
require 'sendpulse/mailing_list'

sendpulse_mailinglist = SendPulse::MailingList.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_mailinglist.delete_emails({ id: id, emails: ["test1@gmail.com"] })
```

#### Retrieving information for specific email address from a mailing list

```ruby
require 'sendpulse/mailing_list'

sendpulse_mailinglist = SendPulse::MailingList.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_mailinglist.get_email({ id: id, email: "test1@gmail.com" })
```

#### Erasing a mailing list

```ruby
require 'sendpulse/mailing_list'

sendpulse_mailinglist = SendPulse::MailingList.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_mailinglist.delete(id)
```

#### Calculating the cost of a campaign carried out by a mailing list

```ruby
require 'sendpulse/mailing_list'

sendpulse_mailinglist = SendPulse::MailingList.new(your_client_id, your_client_secret, 'https', nil)
sendpulse_mailinglist.cost(id)
```

[Here](https://sendpulse.com/integrations/api) is SendPulse API specification.

## Contributing

1. Fork it ( https://github.com/yogahp/SendPulse/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
