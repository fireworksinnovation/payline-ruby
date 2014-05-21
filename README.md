Payline Api for Ruby
=========================

Wrapper around the Payline Api.

[Payline](http://www.payline.co.za/) allows you to proccess credit cards.


Contents
--------

- [How to Install](#how-to-install)
- [Configuration](#configuration)
- [Usage](#usage)

How to Install
--------------

Add this line to your application's Gemfile:

    gem 'payline'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install payline


## Configuration

The best would be to place this in `config/initializers/payline.rb`

```ruby
Payline.configure do |c|
  c.company_name = 'Company Name'
  c.contact_email = 'test@test.com'

  c.sender = "sender_id"
  c.secret = "secret"
  c.user_login = "login"
  c.user_password = "password"
  c.transaction_mode = "INTEGRATOR_TEST"
  c.channel  = "channel_id"
end
```

## Basic usage

```ruby
client = Payline.client
guid = SecureRandom.uuid
amount = "1.00"

card = {
  account_type: 'MASTER', # VISA
  card_number: '1234 1234 1234 1234',
  expiry_year: '2015',
  expiry_month: '01',
  card_holder: 'Mr Y Name',
  cvv: '123'
}

# Reponse can be used in subsequent calls
response = client.reserve(guid, amount, card)

client.reverse(response, amount)

client.capture(response, amount)
```

## Contributing

1. Fork it ( http://github.com/fireworksinnovation/payline-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
