module Hemi::Event
  class EventLoop
    include Hemi::Event::KeyHandler

    def initialize(name, logic, events)
      @name   = name
      @logic  = logic
      register_events!(events)
    end

    attr_reader :name, :logic, :events, :event

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

    def debug!
      Hemi::Engine.debug_on!
    end

    def stop!
      Hemi::Engine.stop!
    end
  end
end
