# Hexx::Domains

[![Gem Version](https://img.shields.io/gem/v/hexx-domains.svg?style=flat)][gem]
[![Build Status](https://img.shields.io/travis/nepalez/hexx-domains/master.svg?style=flat)][travis]
[![Dependency Status](https://img.shields.io/gemnasium/nepalez/hexx-domains.svg?style=flat)][gemnasium]
[![Code Climate](https://img.shields.io/codeclimate/github/nepalez/hexx-domains.svg?style=flat)][codeclimate]
[![Coverage](https://img.shields.io/coveralls/nepalez/hexx-domains.svg?style=flat)][coveralls]

[codeclimate]: https://codeclimate.com/github/nepalez/hexx-domains
[coveralls]: https://coveralls.io/r/nepalez/hexx-domains
[gem]: https://rubygems.org/gems/hexx-domains
[gemnasium]: https://gemnasium.com/nepalez/hexx-domains
[travis]: https://travis-ci.org/nepalez/hexx-domains

Scaffolds the new domain model.

It is a part of [hexx] scaffolders collection.

[hexx]: https://github.com/nepalez/hexx

## Usage

To scaffold a model start the generator:

```
Hexx::Domains::CLI.start %w(
  gemname -r 2.1 -u username -e user@example.com -a Name Family -d -b -g
)
```

The `-u`, `-e` and `-a` options for username, email and author describe themselves.

The `-r` option allows to set minimal MRI ruby to support. Corresponding rbx and jruby versions will be added to `.travis.yml`.

The `-d` options marks the module that has external dependencies. In this case the dummy application will be generated, and the module will be loaded via dummy app.

The `-b` and `-g` options allows running bundler and initializing git repository in the project folder.

## Installation

Add this line to your application's Gemfile:

```ruby
# Gemfile
group :test, :development do
  gem "hexx-domains"
end
```

Then execute:

```
bundle
```

Or add it manually:

```
gem install hexx-domains
```

## Compatibility

Tested under MRI rubies >= 2.1. Rubies under 2.1 aren't supported.

Uses [RSpec] 3.0+ for testing and [hexx-domains-suit] for dev/test tools collection.

## Contributing

* Fork the project.
* Read the [STYLEGUIDE](config/metrics/STYLEGUIDE).
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile or version
  (if you want to have your own version, that is fine but bump version
  in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## License

See the [MIT LICENSE](LICENSE).
