# BacklogKit

[![Gem Version](https://badge.fury.io/rb/backlog_kit.svg)](http://badge.fury.io/rb/backlog_kit)
[![Build Status](https://travis-ci.org/emsk/backlog_kit.svg?branch=master)](https://travis-ci.org/emsk/backlog_kit)
[![Coverage Status](https://coveralls.io/repos/emsk/backlog_kit/badge.svg?branch=master)](https://coveralls.io/r/emsk/backlog_kit)
[![Code Climate](https://codeclimate.com/github/emsk/backlog_kit/badges/gpa.svg)](https://codeclimate.com/github/emsk/backlog_kit)
[![Dependency Status](https://gemnasium.com/emsk/backlog_kit.svg)](https://gemnasium.com/emsk/backlog_kit)

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

### API Key

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
| `BACKLOG_API_KEY` | Your Backlog API KEY. |
| `BACKLOG_OAUTH_CLIENT_ID` | CLIENT ID of your Backlog application. |
| `BACKLOG_OAUTH_CLIENT_SECRET` | CLIENT SECRET of your Backlog application. |
| `BACKLOG_OAUTH_REFRESH_TOKEN` | REFRESH TOKEN obtained from the Backlog token endpoint. |

You can create instance more easily.

```ruby
client = BacklogKit::Client.new
```

## Supported API

* Git
* Group
* Issue
* Notification
* Priority
* Project
* Resolution
* Space
* Star
* Status
* User
* Wiki

See [RDoc](http://www.rubydoc.info/gems/backlog_kit) for more details.

## Supported Ruby Versions

* Ruby 2.0.0
* Ruby 2.1
* Ruby 2.2

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/emsk/backlog_kit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
