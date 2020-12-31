class SDL2::Event
  def structize
    KeyPattern.new(scancode, mod)
  end
end

class Struct
  def eql?(other)
    hash == other.hash
  end
end
