module Hemi::Hud
  class Container
    extend Enum
    include Dimensionable

    enum :anchor, %i[
      top_left
      top
      top_right
      left
      center
      right
      bottom_left
      bottom
      bottom_right
    ]

    @containers = {}

    #   Size and parent cannot be resolved on init, because at this point
    # SDL might not have been initiated at all.
    def initialize(name, size: :full, anchor: nil, color: nil, parent: nil)
      # @pre_values = { size: size, parent: parent }

      @name       = name
      @anchor     = anchor
      @parent     = parent
      @size       = size
      @color      = color

      enum_validate :anchor unless parent.nil?

      register!
    end

    attr_reader :name, :color

    class << self
      # attr_reader :texture_manager

      def register(container)
        @containers[container.name] = container
        # register_texture_manager
      end

      def [](name)
        @containers[name]
      end

      def list
        @containers
      end

      # def register_texture_manager
      #   @texture_manager = Hemi::Render::Texture
      # end
    end

    #   Render the container itself and all the items it includes (future).
    # If size is yet undetermined - we know this container has never been rendered
    # so we calculate size based on parent.
    def render
      register_backround! unless @background

      Hemi::Render::Box[@background].render(position: position)
      # texture_manager.register
      # Hemi::Render::Window.renderer.copy(texture, nil, rectangle(position: position, size: size))
    end

  private

    def register_backround!
      @background = "__hud_box_#{name}".to_sym
      Hemi::Render::Box.new(@background, color: color, size: size)
    end

    def register!
      self.class.register self
    end

    # def texture_manager
    #   self.class.texture_manager
    # end
  end
end
