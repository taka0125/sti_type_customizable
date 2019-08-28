# StiTypeCustomizable

Customize STI type column.

## Status

[![Actions Status](https://github.com/taka0125/sti_type_customizable/workflows/Ruby/badge.svg)](https://github.com/taka0125/sti_type_customizable/actions)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sti_type_customizable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sti_type_customizable

## Usage

- Default STI

```ruby
# type: Message
class Message < ActiveRecord::Base
end

# type: WarningMessage
class WarningMessage < Message
end

# type: ErrorMessage
class ErrorMessage < Message
end
```

- type to integer sample

```ruby
class Message < ActiveRecord::Base
  include StiTypeCustomizable
  
  self.sti_resolver = Resolver.new
end

class WarningMessage < Message
end

class ErrorMessage < Message
end

class Resolver
  include StiTypeCustomizable::Resolver

  def definitions
    @definitions ||= {
      warning_message: 1,
      error_message: 2
    }
  end
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sti_type_customizable.

