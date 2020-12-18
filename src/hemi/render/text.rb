module Hemi::Render
  class Text < Texture
    SDL2::TTF.init

    ALLOWED_MODES = %i[solid blended shaded].freeze
    FONT_FILE_PATTERN = /([\w-]*)_([\d]*)/.freeze

    # ERR__INVALID_FONT_NAME = "Invalid font name format. :font_name_size expected".freeze
    # ERR__INVALID_TEXTURE_SIZE = "Invalid texture size.".freeze
    # ERR__INVALID_POSITION     = "Ivalid position.".freeze

    @fonts = {}

    def initialize(name_size)
      name, size = *name_size.to_s.scan(FONT_FILE_PATTERN).flatten
      @font_path = "assets/fonts/#{name}.ttf"
      @font      = SDL2::TTF.open(font_path, size.to_i)

      Text.register(name_size, self)
    rescue SDL2::Error => _e
      raise ArgumentError, format(ERR__FONT_NOT_FOUND, font_path)
    end

    attr_reader :font_path, :size, :font

    def render(text, position: nil, mode: :blended)
      @texture = Hemi::Window
                 .renderer
                 .create_texture_from(surface(text, mode: mode))
      Hemi::Window.renderer.copy(texture, nil, rectangle(position: position))
    end

    class << self
      attr_reader :fonts

      def bucket
        :fonts
      end
    end

  private

    def surface(text, color: [255, 255, 255], mode: :blended, shade: [0, 0, 0])
      raise(ERR__INVALID_MODE) unless ALLOWED_MODES.include? mode

      case mode
      when :blended, :solid
        font.send("render_#{mode}", text, color)
      when :shaded
        font.render_shaded(text, color, shade)
      end
    end

  end
end
