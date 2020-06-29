require "sdl2"

module Engine::Render
  class Font
    ALLOWED_MODES = %i[solid blended shaded].freeze

    ERR__INVALID_MODE = "Invalid render mode specified".freeze

    attr_reader :font_file, :font, :size

    def initialize(font_file, size: 32)
      @font_file = font_file
      @size = size
      load_font!
    end

    def render(text, color: [255, 255, 255], mode: :blended, shade: [0, 0, 0])
      raise(ERR__INVALID_MODE) unless ALLOWED_MODES.include? mode

      case mode
      when :blended, :solid
        font.send("render_#{mode}", text, color)
      when :shaded
        font.render_shaded(text, color, shade)
      end
    end

  private

    def load_font!
      @font = SDL2::TTF.open(font_file, size)
    end
  end
end
