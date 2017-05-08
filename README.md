# Puma::FseventCleanup

Puma plugin to fix running too many fsevent_watch processes.
Based on https://gist.github.com/steakknife/b318a570803b08c1548c7f51c18c0753

## Problem (on macOS only)

- `Listen` fires up a `fsevent_watch` for every directory watched
- Puma is a **threaded** server, restarting it doesn't restart the Ruby process
- The development server + spring uses `Listen` to hot-reload code (models, views, controllers, etc.)
- Restarting the server doesn't call `#stop` on the `Listen` instances
- Tons and tons of `fsevent_watch` appear until `fork()` fails


## Solution

- Call `#stop` on all `Listen` instances (including yours), to kill off unneeded `fsevent_watch`


## Installation

Add this line to your application's Gemfile:

```ruby
# Gemfile
group :development, :test do
  gem 'puma-fsevent_cleanup'
end
```
And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puma-fsevent_cleanup

Add this to your `config/puma.rb`

```ruby
# config/puma.rb

# kill off fsevent_watch in development
if ENV.fetch('RACK_ENV', 'development') == 'development'
  plugin :fsevent_cleanup
end
```

**Notes**

1. Works with MRI
1. Won't work with JRuby unless ObjectSpace is enabled
1. Might not work on Rubinius
1. Don't use `bin/rails s` use `bin/bundle exec puma` because Rails + Puma + `rails c` is broken (both try to write `tmp/pids/server.pid`, rails doesn't like threaded servers restarting themselves)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/actmd/puma-fsevent_cleanup.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
