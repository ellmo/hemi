module Hemi::Event
  class LoopMachine
    include Singleton

    @loops   = {}
    @current = nil

    attr_reader :event

    def call
      loop do
        Hemi::Render::Window.wipe_screen

        while poll_event
          handle_events LoopMachine.current[:events]

          Hemi::Engine.debug_on! if key_is?(:f12)
        end

        LoopMachine.current[:logic].call

        Hemi::Render::Window.renderer.present
        debug!
        sleep 0.1
      end
    end

    class << self
      attr_reader :loops, :current

      def register(name, logic, events)
        looper       = { logic: logic, events: events }
        @current     = looper if loops.empty?
        @loops[name] = looper

        looper
      end

      def [](name)
        @loops[name]
      end

      def switch(name)
        @current = LoopMachine[name]
      end
    end

  private

    def handle_events(events)
      return unless event_key?

      events[:keys].each_pair do |key, action|
        action.call if key_is?(key)
      end
    end

    def poll_event
      @event = SDL2::Event.poll
    end

    def event_key?
      event.is_a? SDL2::Event::KeyDown
    end

    def key_is?(keycode)
      return nil unless event_key?

      keycode = keycode.to_s.upcase
      event.scancode == SDL2::Key::Scan.const_get(keycode)
    end

    def debug!
      binding.pry if Hemi::Engine.debug # rubocop:disable Lint/Debugger
      Hemi::Engine.debug_off!
    end
  end
end
