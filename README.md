# Globalize3JqueryAutocomplete

Use JQuery autocomplete (via (rails3-jquery-autocomplete)[https://github.com/crowdint/rails3-jquery-autocomplete]) with (globalize3)[https://github.com/svenfuchs/globalize3] translated ActiveRecord models.

Internals: This gem patches the `get_autocomplete_items` method (provided by rails3-jquery-autocomplete) so it works with translated model columns.

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

Simply follow the documentation at (globalize3)[https://github.com/svenfuchs/globalize3] for how to translate your models
and (rails3-jquery-autocomplete)[https://github.com/crowdint/rails3-jquery-autocomplete] for how to set up autocomplete.

## TODO / Future Plans

* Support mongoid and mongomapper
* Tests!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
