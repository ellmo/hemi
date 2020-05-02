require_relative "../unit"

class Mass < Unit
  def initialize(_)
    raise NotImplementedError unless self.class.descendant_of? Mass

    super
  end
end

