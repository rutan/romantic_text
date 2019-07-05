# frozen_string_literal: true

require 'cgi/escape'

module RomanticText
  module Utils
    class << self
      def html_safe?(text)
        text.respond_to?(:html_safe?) ? text.html_safe? : false
      end

      def escape(text)
        html_safe?(text) ? text.to_s : CGI.escapeHTML(text.to_s)
      end
    end
  end
end
