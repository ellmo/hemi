class Unit
  attr_reader :magnitude

  def initialize(magnitude)
    raise NotImplementedError unless self.class < Unit

    @magnitude = magnitude.to_f
  end

  def self.[](magnitude)
    new(magnitude)
  end

  def self.si?
    @si || false
  end

  def to_s
    "#{magnitude}#{unit_literal}"
  end

  def inspect
    "#<Unit #{magnitude}:#{unit_literal}>"
  end

def *(other)
  new_magnitude = if other.is_a? Unit
                    magnitude * other.magnitude
                  elsif other.is_a? Numeric
                    magnitude * other
                  else
                    raise ArgumentError, "cannot multiply by #{other.class}"
                  end
  self.class.new(new_magnitude)
end
end
