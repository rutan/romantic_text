# frozen_string_literal: true

require 'test_helper'

class UtilsTest < Test::Unit::TestCase
  sub_test_case '.html_safe?' do
    test 'normal string is false' do
      assert { RomanticText::Utils.html_safe?('text') == false }
    end

    test 'has html_safe? method' do
      str1 = Object.new
      mock(str1).html_safe? { true }
      assert { RomanticText::Utils.html_safe?(str1) == true }

      str2 = Object.new
      mock(str2).html_safe? { false }
      assert { RomanticText::Utils.html_safe?(str2) == false }
    end
  end

  sub_test_case '.escape' do
    test 'normal string' do
      assert { RomanticText::Utils.escape('text') == 'text' }
      assert { RomanticText::Utils.escape('<script>') == '&lt;script&gt;' }
    end

    test 'has html_safe? method' do
      str1 = Object.new
      mock(str1).html_safe? { true }
      mock(str1).to_s { '<script>' }
      assert { RomanticText::Utils.escape(str1) == '<script>' }

      str2 = Object.new
      mock(str2).html_safe? { false }
      mock(str2).to_s { '<script>' }
      assert { RomanticText::Utils.escape(str2) == '&lt;script&gt;' }
    end
  end
end
