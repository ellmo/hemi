module Engine::Event
  class EventLoop

    attr_reader :window, :event

    def initialize(window)
      @window = window

      loop do
        while poll_event
          exit if key_is?(:escape)
        end

        window.renderer.present
        sleep 0.1
      end
    end

  private

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
  end
end
