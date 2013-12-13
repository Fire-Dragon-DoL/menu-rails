# menu-rails

TODO: Write a gem description

## Interface

`Menu` must respond to:

- `all_menu_items` with an array of all `MenuItem`s
- Must `include MenuRails::BaseMenu`

`MenuItem` must respond to:

- `url` which should return a string (will be an url)
- `text` which should return a string (text displayed for user)
- `authorization` should return `nil` (will be displayed without checking through `can?`) or a hash like this:
  `{ can: :read, class_name: 'ApplicationController' }` which will be used in `can?` method (view) and if false, will
  skip the item

The gem should be threadsafe

## Installation

Add this line to your application's Gemfile:

    gem 'menu-rails', '~> 0.0.1'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install menu-rails

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
