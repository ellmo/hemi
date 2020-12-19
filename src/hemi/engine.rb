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

    def start_loop
      Hemi::Event::EventLoop.new.call(event_table, &loob_block)
    end

    def loob_block
      proc {
        Hemi::Render::Font[:jost_32].render("quick brown fox jumped over the lazy dog", position: [20, 20])
        Hemi::Render::Font[:jost_16].render("quick brown fox jumped over the lazy dog", position: [20, 200])

        Hemi::Render::Sprite[:gem].render(position: { y: 220, x: 20 })
        Hemi::Render::Sprite[:gem].render(position: { y: 320, x: 220 }, size: { height: 64, width: 128 })
      }
    end

    def event_table
      {
        keys: {
          escape: -> { exit },
          q: -> { exit }
        }
      }
    end
  end
end
