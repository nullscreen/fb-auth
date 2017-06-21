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

First, add funky to your Gemfile:

```ruby
gem 'funky'
```
Then run `bundle install`.

Fb::Auth will require an Client ID and an Client Secret which you can obtain after registering as a developer on [Facebook for developers](https://developers.facebook.com/).

By default, Fb::Auth will look for the environment variables called `FB_CLIENT_ID` and `FB_CLIENT_SECRET`. You can put those keys in your `.bash_profile` and Fb::Auth will work.

    ```
    export FB_CLIENT_ID="YourAppID"
    export FB_CLIENT_SECRET="YourAppSecret"
    ```

## Usage

The `url` method helps you obtain a URL where to redirect users who need to
authenticate with their Facebook account in order to use your application:

```ruby
redirect_uri = 'https://example.com/auth' # REPLACE WITH REAL ONE
Fb::Auth.new(redirect_uri: redirect_uri).url
 # => https://www.facebook.com/dialog/oauth?client_id=...&scope=manage_pages&redirect_uri=https%3A%2F%2Fexample.com%2Fauth
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Fullscreen/fb-auth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).