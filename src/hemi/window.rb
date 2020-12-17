require "singleton"
require "sdl2"

module Hemi
  class Window
    include Singleton

    DEFAULT_WINDOW_WIDTH  = 640
    DEFAULT_WINDOW_HEIGHT = 480
    Size = Struct.new(:width, :height, keyword_init: true)

    def initialize(width = DEFAULT_WINDOW_WIDTH, height = DEFAULT_WINDOW_HEIGHT)
      @size = Size.new(width: width, height: height)
    end

    attr_reader :size

    def renderer
      @renderer ||= sdl_window.create_renderer(-1, 0)
    end

    def sdl_window
      @sdl_window ||= SDL2::Window.create(
        "title",
        SDL2::Window::POS_CENTERED,
        SDL2::Window::POS_CENTERED,
        size.width,
        size.height,
        0
      )
    end

    def self.wipe_screen
      instance.renderer.draw_color = [0, 0, 0]
      instance.renderer.fill_rect(SDL2::Rect.new(0, 0, instance.size.width, instance.size.height))
    end

    def self.renderer
      instance.renderer
    end
  end
end
