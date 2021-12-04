module Hemi::Hud
  class Container
    extend Enum

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
      @pre_values = { size: size, parent: parent }

      @name       = name
      @anchor     = anchor
      @parent     = nil
      @size       = nil
      @color      = color
      @background = nil

      enum_validate :anchor unless parent.nil?
      register!

    end

    attr_reader :name, :parent, :color, :size

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
      fetch_parent! && calculate_size! && register_backround! unless size

      Hemi::Render::Box[@background].render(position: Position.new(y: 0, x: 0))
      #texture_manager.register
      # Hemi::Render::Window.renderer.copy(texture, nil, rectangle(position: position, size: size))
    end

  private

    def fetch_parent!
      @parent = case @pre_values[:parent]
                when :root, nil
                  Hemi::Render::Window.instance
                end
    end

    # FIXME: fucking fix me
    def calculate_size!
      @size = case parent
              when Hemi::Render::Window, Hemi::Hud::Container
                case (pre_size = @pre_values[:size])
                when :full
                  parent.size
                when Array # handle exceptions for non 2-element arrays
                  raise ArgumentError if pre_size.count > 2
                  raise ArgumentError if pre_size.map(&:class).uniq.count != 1

                  case pre_size.first
                  when String
                    # need a separate method for parsing percentage strings
                    Size.new(height: parent.size.height * 0.5, width: parent.size.width * 0.5)
                  when Integer
                    Size.new(height: pre_size.first, width: pre_size.last)
                  else
                    # TODO: the following should be a custom exception
                    raise ArgumentError, "Unrecognized size format"
                  end
                when Struct
                  raise NotImplementedError, "Struct data type not supported yet"
                end
              end
    end

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
