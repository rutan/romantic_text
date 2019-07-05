# RomanticText

> A romantic DSL for writing HTML.

## Installation

```ruby
gem 'romantic_text'
```

## Usage

```ruby
require 'romantic_text'

html = RomanticText.markup do
  `#wrapper`['data-version': '1.0'] do
    `h1` << 'Welcome to RomanticText'
    `main.contents`[] do
      `p`[] do
        _ 'This is '
        `strong`[class: 'red'] << 'a romantic DSL'
        _ ' for writing HTML.'
      end
    end
    dangerous_raw_html '<div class="footer">Thanks.</div>'
  end
end

puts html.to_s
# <div id="wrapper" data-version='1.0'>
# <h1>Welcome to RomanticText</h1>
# <main class="contents">
# <p>This is <strong class="red">a romantic DSL</strong> for writing HTML.</p>
# </main>
# <div class="footer">Thanks.</div>
# </div>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rutan/romantic_text.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
