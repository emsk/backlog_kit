# BacklogKit

[![Gem Version](https://badge.fury.io/rb/backlog_kit.svg)](https://badge.fury.io/rb/backlog_kit)
[![Build Status](https://github.com/emsk/backlog_kit/actions/workflows/build.yml/badge.svg)](https://github.com/emsk/backlog_kit/actions/workflows/build.yml)
[![Build Status](https://travis-ci.org/emsk/backlog_kit.svg?branch=main)](https://travis-ci.org/emsk/backlog_kit)
[![Build status](https://ci.appveyor.com/api/projects/status/no4jqaoimctfsejj?svg=true)](https://ci.appveyor.com/project/emsk/backlog-kit)
[![Build Status](https://dev.azure.com/emsk/backlog_kit/_apis/build/status/emsk.backlog_kit?branchName=main)](https://dev.azure.com/emsk/backlog_kit/_build/latest?definitionId=1&branchName=main)
[![Codecov](https://codecov.io/gh/emsk/backlog_kit/branch/main/graph/badge.svg)](https://codecov.io/gh/emsk/backlog_kit)
[![Code Climate](https://codeclimate.com/github/emsk/backlog_kit/badges/gpa.svg)](https://codeclimate.com/github/emsk/backlog_kit)
[![Inline docs](https://inch-ci.org/github/emsk/backlog_kit.svg?branch=main)](https://inch-ci.org/github/emsk/backlog_kit)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Ruby wrapper for the Nulab's Backlog API.

https://developer.nulab.com/docs/backlog/

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

## BacklogKit::Client Config

| Variable | ENV Variable | Description | Default |
| :------- | :----------- | :---------- | :------ |
| `space_id` | `BACKLOG_SPACE_ID` | Your Backlog SPACE ID. ||
| `second_level_domain` | `BACKLOG_SECOND_LEVEL_DOMAIN` | Your Backlog SECOND LEVEL DOMAIN. | `backlog` |
| `top_level_domain` | `BACKLOG_TOP_LEVEL_DOMAIN` | Your Backlog TOP LEVEL DOMAIN. | `com` |
| `api_key` | `BACKLOG_API_KEY` | Your Backlog API KEY. ||
| `client_id` | `BACKLOG_OAUTH_CLIENT_ID` | CLIENT ID of your Backlog application. ||
| `client_secret` | `BACKLOG_OAUTH_CLIENT_SECRET` | CLIENT SECRET of your Backlog application. ||
| `refresh_token` | `BACKLOG_OAUTH_REFRESH_TOKEN` | REFRESH TOKEN obtained from the token endpoint. ||

If you set ENV variables, you can create an instance more simply.

```ruby
client = BacklogKit::Client.new
```

## Supported Backlog API Version

BacklogKit supports Backlog API [2.32.2](https://developer.nulab.com/docs/backlog/changes/#2-32-2-2018-12-18).

BacklogKit's API documentation is [here](https://www.rubydoc.info/gems/backlog_kit).

## Supported Ruby Versions

* Ruby 2.0.0
* Ruby 2.1
* Ruby 2.2
* Ruby 2.3
* Ruby 2.4
* Ruby 2.5
* Ruby 2.6
* Ruby 2.7
* Ruby 3.0
* Ruby 3.1

## Contributing

1. Fork it ( https://github.com/emsk/backlog_kit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

[MIT](LICENSE)
