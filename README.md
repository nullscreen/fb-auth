# Fb::Auth

Fb::Auth can authenticate a Facebook user and return an access token with permission to manage pages of that user.

[![Build Status](http://img.shields.io/travis/Fullscreen/fb-auth/master.svg)](https://travis-ci.org/Fullscreen/fb-auth)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/fb-auth/master.svg)](https://coveralls.io/r/Fullscreen/fb-auth)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/fb-auth.svg)](https://gemnasium.com/Fullscreen/fb-auth)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/fb-auth.svg)](https://codeclimate.com/github/Fullscreen/fb-auth)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/gems/fb-auth/frames)
[![Gem Version](http://img.shields.io/gem/v/fb-auth.svg)](http://rubygems.org/gems/fb-auth)

The **source code** is available on [GitHub](https://github.com/Fullscreen/fb-auth) and the **documentation** on [RubyDoc](http://www.rubydoc.info/gems/fb-auth/frames).
### Installing and Configuring Fb::Auth

First, add fb-auth to your Gemfile:

```ruby
gem 'fb-auth'
```
Then run `bundle install`.

Fb::Auth will require an Client ID and an Client Secret which you can obtain after registering as a developer on [Facebook for developers](https://developers.facebook.com/).

By default, Fb::Auth will look for the environment variables called `FB_CLIENT_ID` and `FB_CLIENT_SECRET`. You can put those keys in your `.bash_profile` and Fb::Auth will work.

    export FB_CLIENT_ID="YourAppID"
    export FB_CLIENT_SECRET="YourAppSecret"

## Usage

Fb::Auth#url
---------------------

The `url` method helps you obtain a URL where to redirect users who need to
authenticate with their Facebook account in order to use your application:

```ruby
redirect_uri = 'https://example.com/auth' # REPLACE WITH REAL ONE
Fb::Auth.new(redirect_uri: redirect_uri).url
 # => https://www.facebook.com/dialog/oauth?client_id=...&scope=manage_pages&redirect_uri=https%3A%2F%2Fexample.com%2Fauth
```

Fb::Auth#access_token
---------------------

After users have authenticated with their Facebook account, they will be
redirected to the `redirect_uri` you indicated, with an extra `code` query
parameter, e.g. `https://example.com/auth?code=1234#_=_`

The `access_token` method allows you to get a non-expiring access token of the user:

```ruby
redirect_uri = 'https://example.com/auth' # REPLACE WITH REAL ONE
code = '1234#_=_' # REPLACE WITH REAL ONE
Fb::Auth.new(redirect_uri: redirect_uri, code: code).access_token
 # => "kefjej49s82hFS@2333233222FDh66"
```

Fb::User#pages
---------------------

Once you have successfully obtain an access token, you can fetch the pages managed
by that access token. Calling `Fb::User.new(access_token).pages` will return an
array of type Fb::Page, each with an id and name.

```ruby
access_token = Fb::Auth.new(redirect_uri: redirect_uri, code: code).access_token
Fb::User.new(access_token).pages
 # => [#<Fb::Page: id="1234", name="sample1">, #<Fb::Page: id="5678", name="sample2">]
```

Fb::User#email
---------------------

Similarly, you can get the email of the user by calling `Fb::User.new(access_token).email`.

```ruby
access_token = Fb::Auth.new(redirect_uri: redirect_uri, code: code).access_token
Fb::User.new(access_token).email
 # => "john.smith@example.com"
```

Fb::Page#insights
---------------------

For each page object, you can fetch page insights for these [available metrics](https://developers.facebook.com/docs/graph-api/reference/v2.9/insights#availmetrics). The insights method takes a hash of three options:

    [String] :since The lower bound of the time range to consider.
    [String] :period The aggregation period (must be available to all
      given metrics).
    [Array] :metric A list of metrics.

Insights will return a hash with the name of each metric as the key and the metric object as the value.

```ruby
options = {
  metric: %i(page_fan_adds_unique page_engaged_users page_views_total),
  period: :week,
  since: '2017-06-09' # sample date format
}
page = Fb::User.new('token').pages.first
page.insights(options)
 # => {"page_fan_adds_unique"=>#<Fb::Metric:0x123abc
 # @name="page_fan_adds_unique", @description="Weekly: The
 # number of new people who have liked your Page (Unique Users)",
 # @value=123>,..}
```

Fb::Error
-------------

`Fb::Error` will be raised when an issue occurs during the Facebook authentication process.
The message of the error will include the details:

```ruby
redirect_uri = 'https://example.com/auth' # REPLACE WITH REAL ONE
code = 'invalid-code'
Fb::Auth.new(redirect_uri: redirect_uri, code: code).access_token
 # => Fb::Error: Invalid verification code format.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
If you would like to run tests for Fb::Auth, please obtain a long-term access token that manages at least one page
and has permission to read your Facebook email (set scope to include `email` and `manage_pages`). Then set the token as
as an environment variable:

    export FB_TEST_ACCESS_TOKEN="YourToken"

Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Fullscreen/fb-auth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
