module Hemi::Render
  class Texture
    ERR__INVALID_POSITION = "Ivalid position.".freeze

    def initialize
      raise NotImplementedError
    end

    attr_reader :texture

    def render
      raise NotImplementedError
    end

    class << self
      def register(name, texture)
        public_send(bucket)[name] ||= texture
      end

      def [](name)
        public_send(bucket)[name] || new(name)
      end

      def purge!
        instance_variable_set "@#{bucket}", {}
      end

      def bucket
        raise NotImplementedError
      end
    end

  private

    def rectangle(size: nil, position: nil)
      SDL2::Rect.new(*calculate_position(position), *calculate_size(size))
    end

    def calculate_size(size = nil)
      size_obj = Size.new(height: nil, width: nil)

      if size.is_a? Array
        size_obj.height = size[0]
        size_obj.width  = size[1]
      elsif size.is_a? Hash
        size_obj.height = size[:height]
        size_obj.width  = size[:width]
      else
        size_obj.height = texture.h
        size_obj.width  = texture.w
      end

      size_obj
    end

    def calculate_position(position = nil)
      position_obj = Position.new(x: nil, y: nil)

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
