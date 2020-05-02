class Vehicle
  ERR__NOT_A_MASS = "`weight` must be in instance of `Mass`".freeze

  def initialize(weight)
    raise NotImplementedError unless self.class.descendant_of? Vehicle
    raise ArgumentError,  unless weight.is_a? Mass

    @weight = weight
  end

  def self.some_class_method
    puts "we all have it"
    puts "here_be_dragons = #{@here_be_dragons}"
  end

  def some_instance_method; end

  def weight_in_lbs
    weight * 2.20462
  end
end
