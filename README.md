# Honeybadger

Simple Honeybadger client for Crystal projects.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  honeybadger:
    github: Nabobil/honeybadger-crystal
```

## Usage

```crystal
require "honeybadger"

begin
  # Some code raising errors
rescue ex
  Honeybadger.notify(ex)
end
```

You can also pass a context and or request:

```crystal
Honeybadger(ex, request: HTTP::Request.new)
Honeybadger(ex, context: { user_id: "123" })
```

## Configuration

Use the following environment variables:

- `HONEYBADGER_API_KEY`
- `HONEYBADGER_ENV`

If the env is not set the client will attempt to fallback using

1. `KEMAL_ENV`
2. `CRYSTAL_ENV`
3. `"development"`

## Development

Set the `HONEYBADGER_API_KEY` to a test project to run specs.

## Contributing

1. Fork it ( https://github.com/Nabobil/honeybadger-crystal/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Nabobil](https://github.com/Nabobil) Nabobil.no AS - creator, maintainer
