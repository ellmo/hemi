module Hemi::Render
  class Box < Texture

    @boxes = {}

    def initialize(name, color: [0, 0, 0], position: nil, size: nil)
      @color    = color
      @position = position
      @size     = size
      Box.register(name, self)
    end

    def render(color: nil, position: nil, size: nil)
      render_color    = color || @color
      render_position = position || @position
      render_size     = size || @size

      renderer.draw_color = render_color
      renderer.fill_rect(SDL2::Rect.new(render_position.x, render_position.y, *render_size))
    end

    def renderer
      Hemi::Render::Window.renderer
    end

    class << self
      attr_reader :boxes

      def bucket
        :boxes
      end
    end
  end
end
