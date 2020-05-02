require "singleton"
require "sdl2"
require_relative "loader"

class Engine
  include Singleton
  include Loader

  DEFAULT_VIDEO_WIDTH  = 640
  DEFAULT_VIDEO_HEIGHT = 480

  attr_reader :window, :debug

  def initialize(vid_height = nil, vid_width = nil)
    @vid_height = vid_height
    @vid_width  = vid_width
    @debug      = false

    sdl_init
    load_trees
  end

  def run
    init_window
    start_loop
  end

  def vid_height
    @vid_height ||= DEFAULT_VIDEO_HEIGHT
  end

  def vid_width
    @vid_width ||= DEFAULT_VIDEO_WIDTH
  end

private

  def sdl_init
    SDL2.init(SDL2::INIT_VIDEO | SDL2::INIT_EVENTS)
  end

  def load_trees
    load_tree "render"
    load_tree "input"
    load_tree "event"
  end

  def init_window
    @window = Engine::Render::Window.new(vid_width, vid_height)
  end

  def start_loop
    @event_loop = Engine::Event::EventLoop.new(window)
  end
end
