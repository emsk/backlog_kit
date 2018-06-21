# BacklogKit

[![Gem Version](https://badge.fury.io/rb/backlog_kit.svg)](http://badge.fury.io/rb/backlog_kit)
[![Build Status](https://travis-ci.org/emsk/backlog_kit.svg?branch=master)](https://travis-ci.org/emsk/backlog_kit)
[![Build status](https://ci.appveyor.com/api/projects/status/no4jqaoimctfsejj?svg=true)](https://ci.appveyor.com/project/emsk/backlog-kit)
[![Codecov](https://codecov.io/gh/emsk/backlog_kit/branch/master/graph/badge.svg)](https://codecov.io/gh/emsk/backlog_kit)
[![Code Climate](https://codeclimate.com/github/emsk/backlog_kit/badges/gpa.svg)](https://codeclimate.com/github/emsk/backlog_kit)
[![Inline docs](http://inch-ci.org/github/emsk/backlog_kit.svg?branch=master)](http://inch-ci.org/github/emsk/backlog_kit)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Ruby wrapper for the Nulab's Backlog API.

http://developer.nulab-inc.com/docs/backlog

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'backlog_kit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install backlog_kit

## Usage

```ruby
require 'backlog_kit'

client = BacklogKit::Client.new(
  space_id: 'emsk',
  api_key: '1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234'
)

client.get_space.body # get body
client.get_space.headers # get headers
client.get_space.status # get status

client.get_space_activities # no params
client.get_space_activities(activity_type_id: [1, 4], min_id: 100) # underscored key
client.get_space_activities(activityTypeId: [1, 4], minId: 100) # camelized key

client.get_groups.body[0].members[0].mail_address # method chaining
```

You can also use low-level methods.

```ruby
client.get('projects/1234/customFields') # GET
client.post('groups', name: 'beer') # POST
client.put('space/notification', content: 'Cheers!') # PUT
client.patch('groups/3712', name: 'whiskey') # PATCH
client.delete('groups/3712') # DELETE
```

## Authentication

### API key

```ruby
client = BacklogKit::Client.new(
  space_id: 'emsk',
  api_key: '1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234'
)
```

### OAuth access token

```ruby
client = BacklogKit::Client.new(
  space_id: 'emsk',
  api_key: nil, # api_key should be nil
  access_token: 'abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcd'
)
```

## ENV

| ENV Variable | Description |
| :----------- | :---------- |
| `BACKLOG_SPACE_ID` | Your Backlog SPACE ID. |
| `BACKLOG_SECOND_LEVEL_DOMAIN` | Your Backlog SECOND LEVEL DOMAIN. |
| `BACKLOG_TOP_LEVEL_DOMAIN` | Your Backlog TOP LEVEL DOMAIN. |
| `BACKLOG_API_KEY` | Your Backlog API KEY. |
| `BACKLOG_OAUTH_CLIENT_ID` | CLIENT ID of your Backlog application. |
| `BACKLOG_OAUTH_CLIENT_SECRET` | CLIENT SECRET of your Backlog application. |
| `BACKLOG_OAUTH_REFRESH_TOKEN` | REFRESH TOKEN obtained from the Backlog token endpoint. |

You can create instance more easily.

```ruby
client = BacklogKit::Client.new
```

## Supported Backlog API Version

BacklogKit supports Backlog API [2.9.0](http://developer.nulab-inc.com/docs/backlog/changes#ver_2.9.0).

BacklogKit's API documentation is [here](http://www.rubydoc.info/gems/backlog_kit).

## Supported Ruby Versions

* Ruby 2.0.0
* Ruby 2.1
* Ruby 2.2
* Ruby 2.3
* Ruby 2.4
* Ruby 2.5

## Development

### Dependencies

##### Production

* [activesupport](https://github.com/rails/rails/tree/master/activesupport)
* [faraday](https://github.com/lostisland/faraday)
* [faraday_middleware](https://github.com/lostisland/faraday_middleware)

##### Development

* [bundler](https://github.com/bundler/bundler)
* [coveralls](https://github.com/lemurheavy/coveralls-ruby)
* [multi_json](https://github.com/intridea/multi_json)
* [rake](https://github.com/ruby/rake)
* [redcarpet](https://github.com/vmg/redcarpet)
* [rspec](https://github.com/rspec/rspec)
* [rubocop](https://github.com/bbatsov/rubocop)
* [simplecov](https://github.com/colszowka/simplecov)
* [vcr](https://github.com/vcr/vcr)
* [webmock](https://github.com/bblimke/webmock)
* [yard](https://github.com/lsegal/yard)

See [`backlog_kit.gemspec`](backlog_kit.gemspec).

## Contributing

1. Fork it ( https://github.com/emsk/backlog_kit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

[MIT](LICENSE)
