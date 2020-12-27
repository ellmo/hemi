class FakeRenderer
  include Singleton

  attr_accessor :draw_color

  def fill_rect(rect); end
  def present; end
end
