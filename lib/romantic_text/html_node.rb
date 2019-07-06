# frozen_string_literal: true

require 'delegate'

module RomanticText
  class HTMLNode < SimpleDelegator
    def initialize(text)
      super(text)
      @parent = nil
    end
    attr_accessor :parent
  end
end
