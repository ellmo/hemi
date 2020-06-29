require "forwardable"

module Engine::Render
  class Window
    extend Forwardable

    attr_reader :fonts, :size

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

    def renderer
      @renderer ||= @sdl_window.create_renderer(-1, 0)
    end
  end
end
