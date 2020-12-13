require "sdl2"

module Engine::Render
  class Text
    ERR__FONT_NOT_FOUND = "Font %s not found.".freeze
    ERR__INVALID_TEXTURE_SIZE =  "Invalid texture size.".freeze
    ERR__INVALID_POSITION = "Ivalid position.".freeze

    attr_reader :window, :renderer, :fonts

    def initialize(window)
      SDL2::TTF.init
      @window   = window
      @renderer = window.renderer
      @fonts = {}
    end

    def render(font_name, text = nil, src: nil, position: nil, size: 16, mode: :blended)
      font = register_font!(font_name, src: src, size: size)

      text          = font.render(text, mode: mode)
      font_texture  = renderer.create_texture_from(text)
      size          = calculate_size(font_texture, size)
      position      = calculate_position(position)

      texture_rect  = SDL2::Rect.new(
        position.x, position.y, size.width, size.height
      )

      renderer.copy(font_texture, nil, texture_rect)
    end

    def register_font!(name, src: nil, size: 16)
      compound_name = "#{name}_#{size}"
      font_path     = src || "assets/fonts/#{name}.ttf"

      fonts[compound_name] ||
        (@fonts[compound_name] = Engine::Render::Font.new(font_path, size: size))
    rescue SDL2::Error => _e
      raise ArgumentError, format(ERR__FONT_NOT_FOUND, font_path)
    end

  private

    def calculate_size(texture, size = nil)
      size_obj = OpenStruct.new(height: nil, width: nil)

      if size.is_a? Array
        size_obj.height = size[0]
        size_obj.width  = size[1]
      elsif size.is_a? Hash
        size_obj.height = size[:height]
        size_obj.width  = size[:widht]
      else
        size_obj.height = texture.h
        size_obj.width = texture.w
      end

      size_obj
    end

    def calculate_position(position = nil)
      position_obj = OpenStruct.new(x: nil, y: nil)

      if position.nil?
        position_obj.x = 0
        position_obj.y = 0
      elsif position.is_a? Array
        position_obj.x = position[0]
        position_obj.y = position[1]
      elsif position.is_a? Hash
        position_obj.x = position[:x]
        position_obj.y = position[:y]
      else
        raise ArgumentError(ERR__INVALID_POSITION)
      end

      position_obj
    end
  end
end
