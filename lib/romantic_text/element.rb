# frozen_string_literal: true

module RomanticText
  class Element
    def initialize(subject = nil, attributes = {})
      @name = pick_element_name(subject)
      @attributes = pick_id_and_classes(subject)
      merge_attributes!(attributes)
      @children = []
    end

    def `(name)
      Element.new(name).tap { |e| @children.push(e) }
    end

    def h(name, attributes = {}, &block)
      public_send(:`, name).render(attributes, &block)
    end

    def <<(str)
      @children.push Utils.escape(str)
    end
    alias_method :text, :<<
    alias_method :_, :<<

    def dangerous_raw_html(str)
      @children.push str.to_s
    end

    def render(attributes = {}, &block)
      merge_attributes!(attributes)
      instance_eval(&block) if block_given?
      self
    end
    alias_method :[], :render

    def to_s
      inner = @children.map(&:to_s).join('')
      return inner if @name.nil?

      generate_tag(@name, @attributes, inner)
    end

    private

    def pick_element_name(subject)
      return nil if subject.nil?

      name = subject.gsub(/(?:#|\.).*\z/, '')
      name.empty? ? 'div' : name
    end

    def pick_id_and_classes(subject)
      return {} if subject.nil?

      group = subject.scan(/(?:#|\.)[^#\.]+/).group_by { |n| n[0] }
      {
        id: group['#'] ? group['#'].first.to_s.delete('#') : nil,
        class: group['.'] ? group['.'].map { |s| s.delete('.') } : nil
      }
    end

    def generate_tag(element_name, attributes, inner_html)
      name = Utils.escape(element_name)
      attr_text = generate_attributes(attributes)
      "<#{name}#{" #{attr_text}" unless attr_text.empty?}>#{inner_html}</#{name}>"
    end

    def generate_attributes(attributes)
      attributes.map do |key, value|
        next if value.nil?
        next if value.is_a?(Array) && value.empty?

        "#{Utils.escape(key)}=\"#{Utils.escape((value.is_a?(Array) ? value.join(' ') : value))}\""
      end.compact.join(' ')
    end

    def merge_attributes!(attributes)
      attributes.each do |key, value|
        case @attributes[key]
        when Array
          if value.is_a?(Array)
            @attributes[key].concat!(value)
          else
            @attributes[key].push value
          end
        else
          @attributes[key] = value.is_a?(Array) ? value : value.to_s
        end
      end
    end
  end
end
