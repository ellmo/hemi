require "forwardable"

module Engine::Event
  class EventLoop
    extend Forwardable

    attr_reader :window, :text, :event

    def_delegator :window, :renderer
    def_delegator :window, :wipe_screen

    def initialize(window, text)
      @window = window
      @text   = text

      loop do
        wipe_screen

        while poll_event
          exit if key_is?(:escape)
          exit if key_is?(:q)
        end

        render_texts

        renderer.present
        sleep 0.1
      end
    end

  private

    def render_texts
      text.render(:jost, "quick brown fox jumped over the lazy dog", size: 32, position: [20, 20])
      text.render(:jost, "quick brown fox jumped over the lazy dog", size: 16, position: [20, 200])
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
  end
end
