module Hemi::Hud
  class Container
    extend Enum
    include Dimensionable

    enum :anchor, Dimensionable::ANCHORS

    @containers = {}

    #   Size and parent cannot be resolved on init, because at this point
    # SDL might not have been initiated at all.
    def initialize(name, size: :full, anchor: nil, color: nil, parent: nil)
      @name       = name
      @anchor     = anchor
      @parent     = parent
      @size       = size
      @color      = color

      enum_validate :anchor unless parent.nil?
    end

    attr_reader :name, :color

    class << self
      def register(name, size: :full, anchor: nil, color: nil, parent: nil)
        container = Container.new(name, size: size, anchor: anchor, color: color, parent: parent)
        @containers[container.name] = container
      end

      def [](name)
        @containers[name]
      end

      def list
        @containers
      end
    end

    #   Render the container itself and all the items it includes (future).
    # If size is yet undetermined - we know this container has never been rendered
    # so we calculate size based on parent.
    def render
      register_backround! unless @background

      Hemi::Render::Box[@background].render(position: position)
    end

  private

    def register_backround!
      @background = "__hud_box_#{name}".to_sym
      Hemi::Render::Box.new(@background, color: color, size: size)
    end
  end
end
