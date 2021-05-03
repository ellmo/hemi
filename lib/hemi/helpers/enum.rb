module Enum
  class EnumCollection
    include Enumerable

    def initialize(elements)
      raise ArgumentError, "Accepts Hash and Array only." unless
        %w[Hash Array].include?(elements.class.name)

      @elements = elements
    end

    def each(&_block)
      @elements.each do |element|
        yield element
      end
    end

    def to_s
      @elements.to_s
    end
  end

  class EnumError < StandardError
    ERR_VALIDATION = "Enum validation failed: %s is not in %s.".freeze
  end

  def enum(name, elements)
    var_name = "@@#{name}".to_sym

    # rubocop:disable Style/ClassVars
    class_eval do |_klass|
      class_variable_set var_name, EnumCollection.new(elements)
      singleton_class.define_method(name) { class_variable_get var_name }
      class_variable_get var_name
    end
    # rubocop:enable Style/ClassVars
  end

  def self.extended(klass)
    instance_eval do
      klass.define_method(:enum_validate) do |name|
        klass_var = klass.class_variable_get("@@#{name}")
        insta_var = instance_variable_get("@#{name}")

        return if klass_var.include?(insta_var)

        raise EnumError, format(EnumError::ERR_VALIDATION, insta_var, klass_var)
      end
    end
  end
end
