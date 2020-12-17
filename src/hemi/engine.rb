require "singleton"
require "forwardable"
require "sdl2"

require_relative "../helpers"
require_relative "loader"
require_relative "window"

module Hemi
  class Engine
    include Singleton

    @debug = false

    def initialize
      sdl_init
      load_trees
    end

    attr_reader :window, :text, :image, :debug

    def run
      init_window
      init_text
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
      Loader.load_tree "render"
      Loader.load_tree "input"
      Loader.load_tree "event"
    end

    def init_window
      @window = Hemi::Window.instance
    end

    def init_text
      @text = Hemi::Render::Text.new
    end

    def start_loop
      Hemi::Event::EventLoop.new(text, image).call
    end
  end
end
