require_relative "../vehicle"

class StationWagon < Vehicle

  def initialize
    super(Kilogram.new 2500)
  end
end
