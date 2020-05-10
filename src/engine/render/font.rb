require "sdl2"

module Engine::Render
  class Font

    attr_reader :font_file, :font

    def initialize(font_file, size: 32)
      @font_file = font_file
      @size = size
      load_font!
    end

    def render(text)
      font.render_solid(text, [255, 255, 255])
    end

  private

    def load_font!
      @font = SDL2::TTF.open(font_file, size)
    end
  end
end
