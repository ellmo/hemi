require_relative "../mass"

class Kilogram < Mass
  @si = true

  def unit_literal
    "kg"
  end

  def to_s
    puts "dupa"
    binding.pry
    super
  end
end
