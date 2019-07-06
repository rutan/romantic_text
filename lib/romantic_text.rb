# frozen_string_literal: true

require 'romantic_text/version'
require 'romantic_text/utils'
require 'romantic_text/html_node'
require 'romantic_text/element'

module RomanticText
  class << self
    def markup(&block)
      Element.new.render(&block)
    end
  end
end
