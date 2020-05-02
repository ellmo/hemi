module Engine::Render
  class Window

    def initialize(width, height)
      @sdl_window = SDL2::Window.create(
        "title",
        SDL2::Window::POS_CENTERED,
        SDL2::Window::POS_CENTERED,
        width,
        height,
        0
      )
    end

    def renderer
      @renderer ||= @sdl_window.create_renderer(-1, 0)
    end
  end
end
