require "forwardable"

module Engine::Render
  class Window
    def initialize(width, height)
      @size = OpenStruct.new(width: width, height: height)

      @sdl_window = SDL2::Window.create(
        "title",
        SDL2::Window::POS_CENTERED,
        SDL2::Window::POS_CENTERED,
        size.width,
        size.height,
        0
      )
    end

    attr_reader :fonts, :size

    def renderer
      @renderer ||= @sdl_window.create_renderer(-1, 0)
    end

    def wipe_screen
      # renderer.draw_color = [rand(0..255), 0, 0]
      renderer.draw_color = [0, 0, 0]
      renderer.fill_rect(SDL2::Rect.new(0, 0, size.width, size.height))
    end
  end
end
