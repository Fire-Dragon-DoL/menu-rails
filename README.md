# menu-rails

This gem provide a set of helpers and methods that allow to easily generate a menu and identify
the currently active link item.  
Comes with support to generate menu from a YAML file in config directory, but supports generation
even from database (or whatever you want).

## Features

- Threadsafe (not tested)
- Menu generation from YAML file
- Menu generation from any other source (database for example)
- Check which menu item is active
- Cancan support

## How to generate menu from database

You must create 2 classes which will respond to some methods:

A `Menu` class which must respond to:

- `all_menu_items` with an array of menu items
- Must `include MenuRails::BaseMenu`

A `MenuItem` class which must respond to:

- `url` *String* which must be a valid url
- `text` *String* which is text displayed to users
- `authorization` should return `nil` (will be displayed without checking through `can?`) or a hash like this:
  `{ can: :read, class_name: 'ApplicationController' }` which will be used in `can?` method (view) and if false, will skip the item
- `active_controller_only` *Boolean* `false` if you want to check both against controller and action name if this link is currently active. If `true`, only controller will be checked
- `active_method` *Symbol* if not `nil`, will be called instead of standard `active?` method (and `active_controller_only` ignored)

The gem should be threadsafe

## Installation

Add this line to your application's Gemfile:

    gem 'menu-rails', '~> 0.1.0'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install menu-rails

## Usage

TODO: Write usage instructions here

## TODO

- Split `Menu` and `MenuItem` classes into 2 pairs, `MenuBase` will not include anything related to `has_no_table`, same for `MenuItemBase`
- I18n support (very important, for menu text string)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
