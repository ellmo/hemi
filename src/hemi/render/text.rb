module Hemi::Render
  class Text
    ERR__INVALID_TEXTURE_SIZE = "Invalid texture size.".freeze
    ERR__INVALID_POSITION     = "Ivalid position.".freeze

    def initialize
      SDL2::TTF.init
    end

    def render(font, text = nil, position: nil, mode: :blended)
      texture       = Font[font].texturize(text, mode: mode)
      font_texture  = Hemi::Window.renderer.create_texture_from(texture)
      size          = calculate_size(font_texture, size)
      position      = calculate_position(position)
      texture_rect  = SDL2::Rect.new position.x, position.y, size.width, size.height

      Hemi::Window.renderer.copy(font_texture, nil, texture_rect)
    end

  private

    def calculate_size(texture, size = nil)
      size_obj = OpenStruct.new(height: nil, width: nil)

      if size.is_a? Array
        size_obj.height = size[0]
        size_obj.width  = size[1]
      elsif size.is_a? Hash
        size_obj.height = size[:height]
        size_obj.width  = size[:width]
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
