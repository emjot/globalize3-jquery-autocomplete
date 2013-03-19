# Globalize3JqueryAutocomplete

Make rails3-jquery-autocomplete work with globalize3 translated models.

Only ActiveRecord models are supported at the moment (no mongo).

Without this gem, `get_autocomplete_items` will not work correctly with translated model columns.

## Compatibility

rails3-jquery-autocomplete 1.0 and globalize3 0.3 are supported.

## Installation

Add this line to your application's Gemfile:

    gem 'globalize3-jquery-autocomplete'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install globalize3-jquery-autocomplete

## Usage

Simply include this gem in your Gemfile.

## TODO / Future Plans

* Support mongoid and mongomapper
* Tests!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
