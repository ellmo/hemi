require "singleton"
require "forwardable"
require "sdl2"

require_relative "loader"

class Engine
  include Singleton
  include Loader
  extend Forwardable

  DEFAULT_VIDEO_WIDTH  = 640
  DEFAULT_VIDEO_HEIGHT = 480

  attr_reader :window, :text, :debug

  def_delegator :window, :renderer

  @debug = false

  def initialize(vid_height = nil, vid_width = nil)
    @vid_height = vid_height
    @vid_width  = vid_width

    sdl_init
    load_trees
  end

  def run
    init_window
    init_text
    start_loop
  end

  def vid_height
    @vid_height ||= DEFAULT_VIDEO_HEIGHT
  end

  def vid_width
    @vid_width ||= DEFAULT_VIDEO_WIDTH
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
    @window = Engine::Render::Window.new(vid_width, vid_height)
  end

  def init_text
    @text = Engine::Render::Text.new(window)
  end

  def start_loop
    @event_loop = Engine::Event::EventLoop.new(window, text)
  end
end
