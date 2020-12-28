module Hemi::Event
  class EventLoop
    include Hemi::Event::KeyHandler

    def initialize(logic, events)
      @logic  = logic
      register_events!(events)
    end

    attr_reader :logic, :events, :event

    def handle(event)
      @event = event

      case event
      when SDL2::Event::KeyDown
        handle_key
      end
    end

    def process
      logic.call
    end

  private

    def handle_key
      case action = events[[event.scancode, event.mod]]
      when Symbol
        instance_eval action.to_s
      when Proc
        action.call
      end
    end

    def debug!
      Hemi::Engine.debug_on!
    end

    def stop!
      Hemi::Engine.stop!
    end
  end
end
