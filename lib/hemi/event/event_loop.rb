module Hemi::Event
  class EventLoop

    def initialize(logic, events)
      @logic  = logic
      @events = events.each_with_object({}) do |(key, action), hsh|
        hsh[SDL2::Key::Scan.const_get(key.upcase)] = action
      end
    end

    attr_reader :logic, :events, :event

    def handle(event)
      @event = event

      case event
      when SDL2::Event::KeyDown
        handle_key
      end

      @event = nil
    end

    def process
      logic.call
    end

  private

    def handle_key
      case action = events[event.scancode]
      when Symbol
        instance_eval action.to_s
      when Proc
        action.call
      end
    end

    def key_event?
      event.is_a?
    end

    def key_down
      return unless key_event?

      SDL2::Key::Scan.const_get(event.scancode).downcase
    end

    def debug!
      Hemi::Engine.debug_on!
    end
  end
end
