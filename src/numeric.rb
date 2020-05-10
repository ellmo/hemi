class Numeric
  def kg
    Kilogram.new(self)
  end

  def lbs
    Pound.new(self)
  end
end
