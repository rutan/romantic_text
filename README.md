# RomanticText

> A romantic DSL for writing HTML.

<!-- TOC -->

- [RomanticText](#romantictext)
    - [Installation](#installation)
    - [Usage](#usage)
        - [Simply](#simply)
        - [Attributes](#attributes)
        - [Shorthand id / class](#shorthand-id--class)
        - [Escape HTML](#escape-html)
        - [Use `h` method](#use-h-method)
    - [Motivation](#motivation)
    - [Contributing](#contributing)
    - [License](#license)

<!-- /TOC -->

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

### Simply

```ruby
html = RomanticText.markup do
  `div` << 'Hello'
end
html.to_s # => <div>Hello</div>

html = RomanticText.markup do
  `div`[] do
    _ 'Hello'
  end
end
html.to_s # => <div>Hello</div>
```

### Attributes

```ruby
html = RomanticText.markup do
  `a`[class: 'my-class', href: 'https://example.com'] do
    _ 'link'
  end
end
html.to_s # => <a class="my-class" href="https://example.com">link</a>
```

### Shorthand id / class

```ruby
html = RomanticText.markup do
  `#my-id` << 'text'
  `p.my-class1.my-class2` << 'text'
end
html.to_s # => <div id="my-id">text</div><p class="my-class1 my-class2">text</p>
```

### Escape HTML

```ruby
# safe :)
html = RomanticText.markup do
  `div`[] do
    _ '<script>alert(1)</script>'
  end
end
html.to_s # => <div>&lt;script&gt;alert(1)&lt;/script&gt;</div>

# danger :(
html = RomanticText.markup do
  `div`[] do
    dangerous_raw_html '<script>alert(1)</script>'
  end
end
html.to_s # => <div><script>alert(1)</script></div>
```

### Use `h` method

```ruby
html1 = RomanticText.markup do
  `p`[class: 'red'] do
    `strong` << 'Hello'
  end
end

html2 = RomanticText.markup do
  h('p', class: 'red') do
    h('strong') << 'Hello'
  end
end

html1.to_s == html2.to_s # => true
```

## Motivation

I think backquote method is very very exciting :laughing:

```ruby
class Hoge
  def `(arg)
    arg.upcase
  end

  def custom_eval(&block)
    instance_eval(&block)
  end
end

Hoge.new.custom_eval { `hello` } # => HELLO
```

It can be used like [Tagged templates in JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rutan/romantic_text.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
