require "singleton"
require "sdl2"

module Engine
  class Window
    include Singleton

    DEFAULT_WINDOW_WIDTH  = 640
    DEFAULT_WINDOW_HEIGHT = 480
    Size = Struct.new(:width, :height, keyword_init: true)

    def initialize(width = DEFAULT_WINDOW_WIDTH, height = DEFAULT_WINDOW_HEIGHT)
      @size = Size.new(width: width, height: height)

      @sdl_window = SDL2::Window.create(
        "title",
        SDL2::Window::POS_CENTERED,
        SDL2::Window::POS_CENTERED,
        size.width,
        size.height,
        0
      )
    end

    attr_reader :size

    def renderer
      @renderer ||= @sdl_window.create_renderer(-1, 0)
    end

    def wipe_screen
      renderer.draw_color = [0, 0, 0]
      renderer.fill_rect(SDL2::Rect.new(0, 0, size.width, size.height))
    end

    def self.renderer
      instance.renderer
    end
  end
end
