# frozen_string_literal: true

require 'test_helper'

class RomanticTextTest < Test::Unit::TestCase
  sub_test_case '#markup' do
    test 'simple' do
      html1 = RomanticText.markup do
        `div`
      end

      html2 = RomanticText.markup do
        h('div')
      end

      result = '<div></div>'

      assert { html1.to_s == result }
      assert { html2.to_s == result }
    end

    test 'multi items' do
      html1 = RomanticText.markup do
        `h1`
        `h2`
        `p`
      end

      html2 = RomanticText.markup do
        h('h1')
        h('h2')
        h('p')
      end

      result = '<h1></h1><h2></h2><p></p>'

      assert { html1.to_s == result }
      assert { html2.to_s == result }
    end

    test 'nesting' do
      html1 = RomanticText.markup do
        `div`[] do
          `p` << 'Hello, World'
          `p`[] do
            _ 'Good HTML!'
          end
        end
      end

      html2 = RomanticText.markup do
        h('div') do
          h('p') << 'Hello, World'
          h('p') do
            _ 'Good HTML!'
          end
        end
      end

      result = '<div><p>Hello, World</p><p>Good HTML!</p></div>'

      assert { html1.to_s == result }
      assert { html2.to_s == result }
    end

    test 'attributes' do
      html1 = RomanticText.markup do
        `ul`[class: 'item-list', 'data-items': [1, 2, 3]] do
          `li`[class: 'item'] << 1
          `li`[class: 'item'] << 2
          `li`[class: 'item'] << 3
        end
      end

      html2 = RomanticText.markup do
        h('ul', class: 'item-list', 'data-items': [1, 2, 3]) do
          h('li', class: 'item') << 1
          h('li', class: 'item') << 2
          h('li', class: 'item') << 3
        end
      end

      result =
        '<ul class="item-list" data-items="1 2 3">' \
        '<li class="item">1</li><li class="item">2</li><li class="item">3</li>' \
        '</ul>'

      assert { html1.to_s == result }
      assert { html2.to_s == result }
    end

    test 'short hand id and class' do
      html1 = RomanticText.markup do
        `#wrapper.wrapper`[class: 'attr-class'] do
          `p.text` << 'attributes'
          `p.text#text`[id: 'attr-id'] << 'attributes'
        end
      end

      html2 = RomanticText.markup do
        h('#wrapper.wrapper', class: 'attr-class') do
          h('p.text') << 'attributes'
          h('p.text#text', id: 'attr-id') << 'attributes'
        end
      end

      result =
        '<div id="wrapper" class="wrapper attr-class">' \
        '<p class="text">attributes</p>' \
        '<p id="attr-id" class="text">attributes</p>' \
        '</div>'
      assert { html1.to_s == result }
      assert { html2.to_s == result }
    end

    test 'escape text' do
      html1 = RomanticText.markup do
        `.article`['data-html': '<p class="test">Hi!</p>'] do
          `a.title`[href: 'https://example.com?hoge=1'] << '<script>alert(1)</script>'
          `.body`[] do
            dangerous_raw_html '<p>body</p>'
          end
        end
      end

      html2 = RomanticText.markup do
        h('.article', 'data-html': '<p class="test">Hi!</p>') do
          h('a.title', href: 'https://example.com?hoge=1') << '<script>alert(1)</script>'
          h('.body') do
            dangerous_raw_html '<p>body</p>'
          end
        end
      end

      result =
        '<div class="article" data-html="&lt;p class=&quot;test&quot;&gt;Hi!&lt;/p&gt;">' \
        '<a class="title" href="https://example.com?hoge=1">&lt;script&gt;alert(1)&lt;/script&gt;</a>' \
        '<div class="body"><p>body</p></div>' \
        '</div>'
      assert { html1.to_s == result }
      assert { html2.to_s == result }
    end

    test 'use escaped text' do
      escaped_text = Object.new
      mock(escaped_text).html_safe? { true }
      mock(escaped_text).to_s { '<b>big</b>' }

      html = RomanticText.markup do
        `span` << escaped_text
      end

      assert { html.to_s == '<span><b>big</b></span>' }
    end
  end
end
