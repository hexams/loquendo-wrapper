# Loquendo

Ruby wrapper for Loquendo TTS

## Installation

Add this line to your application's Gemfile:

    gem 'loquendo-wrapper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install loquendo-wrapper

## Usage

```ruby
require "loquendo"

data = Loquendo.convert("the book is on de table")

file = File.new("/tmp/sound.alaw", "w")
file.write(data)
file.close
```

## Author

Copyright (c) 2012 Patrick Ximenes. MIT licence (see LICENSE for details).

