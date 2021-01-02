module Hemi::Event
  # The brain of the operation. A state machine which keeps performing assigned logic, while
  # listening for assigned events.
  class LoopMachine
    include Singleton

    @loops   = {}
    @current = nil

    # @return [SDL2::Event] the last/current SDL event being handled.
    # @api private
    attr_reader :event

    # Main operation method. Performs these steps in order:
    #
    # 1. Wipes the current window (by drawing a black rectangle over it).
    # 2. Checks if SDL picked up any events and handles them.
    # 3. Processes the "frame" logic: calculating, moving and drawing to framebuffer.
    # 4. Copies the frame's content from framebuffer to display (inside the window).
    # 5. Checks if `Hemi::Engine.debug` has been set to `true`; opens a `pry` session if so.
    # 6. Checks if `Hemi::Engine.stop` has been set to `true`; breaks from the loop if so.
    # 7. Sleeps for a hardcoded amount of time.
    #
    # @note This method is being automatically called by {Hemi::Engine#run Hemi::Engine's} `#run`.
    def call
      loop do
        Hemi::Render::Window.wipe_screen

        handle_events while poll_event
        process_logic

        Hemi::Render::Window.renderer.present

        debug?
        break if Hemi::Engine.stop

        sleep 0.1
      end
    end

    class << self
      # @return [Hash] A simple collection of "loop-states", with as their keys,
      #   and {EventLoop} instances as values.
      attr_reader :loops
      # @return [EventLoop] The currently active "loop-state", which logic and events are being
      #   handled in the main `#call` loop.
      attr_reader :current

      # Registers an {EventLoop} in the `@loops` collection with the `name` as its identifier.
      # If the collection was empty before registration, the first {EventLoop} is automatically
      # set as _current_.
      #
      # @param [Symbol] name The {EventLoop}'s identifier, i.e. - a key in `@loops` collection.
      # @param [Proc] logic Proc-wrapped logic to be ran at every iteration of the loop (frame).
      # @param [Hash] events A simple collection of events and their corresponding actions.
      #
      # @example excerpt from demo/01-loop_machine_demo.rb
      #   class LoopMachineDemo
      #     prepend Hemi::Engine
      #     LM = Hemi::Event::LoopMachine
      #
      #     def run
      #      LM.register(:text, text_block, text_events)
      #      LM.register(:image, sprite_block, sprite_events)
      #     end
      #   end
      def register(name, logic = proc {}, events = {})
        event_loop   = EventLoop.new(logic, events)
        @current     = event_loop if loops.empty?
        @loops[name] = event_loop

        event_loop
      end

      # Fetch a registered {EventLoop} from `@loops` collection.
      #
      # @param [Symbol] name
      # @return [EventLoop]
      def [](name)
        @loops[name]
      end

      # Transitions to another state, setting its {EventLoop} as `@current`. Starts performing its
      # logic and listening to its events.
      def switch(name)
        @current = LoopMachine[name]
      end

      # Empties `@loops` collection and sets `@current` state to nil. Currently only used
      # to ensure spec scenario isolation.
      #
      # @api private
      def purge!
        @loops   = {}
        @current = nil
      end
    end

  private

    def handle_events
      LoopMachine.current.handle event
    end

    def process_logic
      LoopMachine.current.process
    end

    def poll_event
      @event = SDL2::Event.poll
    end

    def debug?
      binding.pry if Hemi::Engine.debug # rubocop:disable Lint/Debugger
      Hemi::Engine.debug_off!
    end
  end
end
