require "singleton"
require "forwardable"
require "sdl2"

require_relative "window"
require_relative "loader"

module Hemi
  class Engine
    include Singleton
    include Loader

    @debug = false

    def initialize
      sdl_init
      load_trees
    end

    attr_reader :window, :text, :image, :debug

    def run
      init_window
      init_text
      init_image
      start_loop
    end

    class << self
      attr_reader :debug

      def debug_on!
        @debug = true
      end

      def debug_off!
        @debug = false
      end
    end

  private

    def sdl_init
      SDL2.init(SDL2::INIT_EVERYTHING)
    end

    def load_trees
      load_tree "render"
      load_tree "input"
      load_tree "event"
    end

    def init_window
      @window = Hemi::Window.instance
    end

    def init_text
      @text = Hemi::Render::Text.new(window)
    end

    def init_image
      @image = Hemi::Render::Image.new(window)
    end

    def start_loop
      Hemi::Event::EventLoop.new(window, text, image).call
    end
  end
end
