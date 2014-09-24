# Attribute Boolean

The purpose of this gem is to provide an `attr_boolean` shortcut to classes.
This shortcut creates accessors that, when assigned to with a variety of
"falsey" or "truthy" data, can be interpreted as intended.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'attribute_boolean'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attribute_boolean

## Usage

In a standard Ruby class, you might have something like this:

```ruby
class Calculation

  include AttributeBoolean

  attr_boolean :complete

end
```

This provides you with the `"#{attr}="` and `"#{attr}?"` methods:

```ruby
c = Calculation.new

c.complete = "1"
c.complete? #=> true

c.complete = "0"
c.complete? #=> false

c.complete = "yes"
c.complete? #=> true

c.complete = "no"
c.complete? #=> false
```

The default values that are interpreted as `false` is:

```ruby
[ false, 0, '0', 'f', 'F', 'false', 'FALSE', 'off', 'OFF', 'n', 'N', 'no', 'NO' ]
```

This can be customized globally like this:

```ruby
AttributeBoolean.false_values = [ "dunno", -1, :negative ]
AttributeBoolean.false_values += [ "no way", 0 ]
```

Or the `false_values` list can be set individually per `attr_boolean` call.
Using this option will replace the global list for that attribute.

```ruby
attr_boolean :complete, false_values: [ 'it is not complete', 'not completed', :nope ]
attr_boolean :in_progress, false_values: Set.new(:no, 'nope')
```

Specify a default value for the attribute that will be used if it (1) hasn't
been set, or (2) has been set to nil. The value passed to `default` is
casted to a boolean using `!!default`.

```ruby
attr_boolean :complete, default: true
```

AttributeBoolean converts all symbols to strings when evaluating truthiness:

```
obj.complete = :no
obj.complete? #=> false

obj.complete = :yes
obj.complete? #=> true
```

### Rails

If Rails is loaded when this gem loads, it will automatically inject the
`AttributeBoolean` module into `ActiveRecord::Base`, preventing the need to
call `include AttributeBoolean` on ActiveRecord classes.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/attribute_boolean/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
