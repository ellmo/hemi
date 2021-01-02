require "singleton"
require "sdl2"

require_relative "loader"

module Hemi
  # Entry-level module, meant to be _prepended_ in the main class of the game using the `hemi` gem.
  #
  # Prepending this module allows developers to write their custom +initialize+ and +run+ methods
  # without overriding any of the mandatory logic. Becasue of the `prepend` behavior,
  # `Hemi::Engine` will end up first in ancestors' list.
  #
  # So, technically, if `Game` implements its own `initialize` / `run` methods, those will be
  # super-called from `Hemi::Engine`.
  #
  # @example using the engine
  #   require "hemi"
  #
  #   class Game
  #     prepend Hemi::Engine
  #
  #     def initialize
  #       [...]
  #     end
  #
  #     def run
  #       [...]
  #     end
  #   end
  #
  #   Game.instance.run
  #
  # @example ancestors list
  #   Game.ancestors
  #   => [Hemi::Engine, Game, Singleton, Object, PP::ObjectMixin, Kernel, BasicObject]
  module Engine
    @debug = false
    @stop  = false

    # Initializes all required `SDL` modules and then proceeds to execute the constructor of the
    # class it prepends.
    def initialize
      sdl_init
      super
    end

    # @return [SDL2::Window]
    # @api private
    attr_reader :window

    class << self
      # @return [Boolean] Returns `true` if the engine is set to debugging mode.
      attr_reader :debug
      # @return [Boolean] Returns `true` if the engine is set gracefully exit upon finishing the
      #   next loop.
      attr_reader :stop

      # As mentioned - this module is meant to be _prepended_ in the main game class. When
      # prepended, this method is automatically ran, making the class a Singleton and makes sure all
      # `Hemi` modules are loaded in required order.
      #
      # @param [Class] klass
      def prepended(klass)
        klass.include Singleton

        Loader.load_tree "helpers"
        Loader.load_tree "render"
        Loader.load_tree "input"
        Loader.load_tree "event"
      end

      # Sets `@debug` instance variable to `true`. Doing this will trigger the current
      # {Hemi::Event::LoopMachine#call LoopMachine's} {Hemi::Event::EventLoop EventLoop} to stop at
      # the nearest `binding.pry` (thus, halting the game and allowing game's current state to be
      # debugged).
      #
      # @note Ideally this method should NOT be called manually, {Hemi::Event::EventLoop EventLoop}
      #   calls it when it receives an event resulting in a `:debug!` action.
      #
      # @api private
      def debug_on!
        @debug = true
      end

      # Sets `@debug` instance variable to `false`. This makes sure that after opening a pry
      # REPL session and ending it with calling `exit` from pry's REPL, the `@debug` flag is off
      # and the program can continue operating normally.
      #
      # @note Ideally this method should NOT be called manually. It is called internally right after
      #   {Hemi::Event::LoopMachine#call LoopMachine} handles `binding.pry` in `#debug?` method.
      #
      # @api private
      def debug_off!
        @debug = false
      end

      # Sets `@stop` instance variable to `true`. This triggers a _graceful_ exit of the entire
      # {Hemi::Event::LoopMachine#call LoopMachine's} {Hemi::Event::EventLoop EventLoop} - and,
      # by extension, exits the program upon the next complete loop.
      #
      # @note Ideally this method should NOT be called manually, {Hemi::Event::EventLoop EventLoop}
      #   calls it when it receives an event resulting in a `:stop!` action.
      #
      # @api private
      def stop!
        @stop = true
      end
    end

    # Starts the game engine. Takes care of all custom logic in prepended class' `#run` method, then
    # initializes a program window and calls {Hemi::Event::LoopMachine LoopMachine} to start running
    # its event loops.
    def run
      super if defined?(super)
      init_window
      start_loop
    end

  private

    def sdl_init
      SDL2.init(SDL2::INIT_EVERYTHING)
    end

    def init_window
      @window = Hemi::Render::Window.instance
    end

    def start_loop
      Hemi::Event::LoopMachine.instance.call
    end
  end
end
