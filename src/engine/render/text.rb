require "sdl2"

module Engine::Render
  class Text
    ERR__FONT_NOT_REG = "No font by this name is registered.".freeze

    attr_reader :window, :renderer

    def initialize(window)
      binding.pry
      SDL2::TTF.init
      @window   = window
      @renderer = window.renderer
      @fonts = {}
    end

    def register_font(name, font_file)
      check_font_registration!
      fonts[name] = Engine::Render::Font.new(font_file)
    end

    def render(font_name, text)
      check_font_registration!
      fonts[font_name].render(text)
    end

  private

    def check_font_registration!
      raise ArgumentError(ERR__FONT_NOT_REG) unless fonts[name].nil?
    end

  end
end
