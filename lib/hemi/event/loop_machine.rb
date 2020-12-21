module Hemi::Event
  class LoopMachine
    include Singleton

    @loops   = {}
    @current = nil

    attr_reader :event

    def call
      loop do
        Hemi::Render::Window.wipe_screen

        handle_events while poll_event
        process_logic

        Hemi::Render::Window.renderer.present
        debug!
        sleep 0.1
      end
    end

    class << self
      attr_reader :loops, :current

      def register(name, logic, events)
        event_loop   = EventLoop.new(logic, events)
        @current     = event_loop if loops.empty?
        @loops[name] = event_loop

        event_loop
      end

      def [](name)
        @loops[name]
      end

      def switch(name)
        @current = LoopMachine[name]
      end

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

    def debug!
      binding.pry if Hemi::Engine.debug # rubocop:disable Lint/Debugger
      Hemi::Engine.debug_off!
    end
  end
end
