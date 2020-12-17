require "sdl2"

module Hemi::Render
  class Font
    ALLOWED_MODES = %i[solid blended shaded].freeze
    FONT_FILE_PATTERN = /([\w-]*)_([\d]*)/.freeze

    ERR__FONT_NOT_FOUND = "Font %s not found.".freeze
    ERR__INVALID_MODE   = "Invalid render mode specified".freeze

    @fonts = {}

    def initialize(font_file, size: 16)
      @font_file = font_file
      @size = size
      load_font!
    end

    attr_reader :font_file, :font, :size

    def texturize(text, color: [255, 255, 255], mode: :blended, shade: [0, 0, 0])
      raise(ERR__INVALID_MODE) unless ALLOWED_MODES.include? mode

      case mode
      when :blended, :solid
        font.send("render_#{mode}", text, color)
      when :shaded
        font.render_shaded(text, color, shade)
      end
    end

    class << self
      attr_reader :fonts

      def register(name, size = 16)
        compound_name       = "#{name}_#{size}".to_sym
        font_path           = "assets/fonts/#{name}.ttf"
        Font[compound_name] = Hemi::Render::Font.new(font_path, size: size.to_i)
      rescue SDL2::Error => _e
        raise ArgumentError, format(ERR__FONT_NOT_FOUND, font_path)
      end

      def [](font_name)
        @fonts[font_name] || register(*font_name.to_s.scan(FONT_FILE_PATTERN).flatten)
      end

    protected

      def []=(font_name, font)
        @fonts[font_name] = font
      end
    end

  private

    def load_font!
      @font = SDL2::TTF.open(font_file, size)
    end
  end
end
