require "forwardable"

module Hemi::Event
  class EventLoop
    extend Forwardable
    Font   = Hemi::Render::Font
    Sprite = Hemi::Render::Sprite

    def initialize(text, image)
      @text  = text
      @image = image
    end

    attr_reader :text, :image, :event

    def call
      loop do
        Hemi::Window.wipe_screen

        while poll_event
          exit if key_is?(:escape)
          exit if key_is?(:q)

          Hemi::Engine.debug_on! if key_is?(:f12)
        end

        render_texts
        render_sprites

        Hemi::Window.renderer.present
        debug!
        sleep 0.1
      end
    end

  private

    def render_texts
      Font[:jost_32].render("quick brown fox jumped over the lazy dog", position: [20, 20])
      Font[:jost_16].render("quick brown fox jumped over the lazy dog", position: [20, 200])
    end

    def render_sprites
      Sprite[:gem].render(position: { y: 220, x: 20 })
      Sprite[:gem].render(position: { y: 320, x: 220 }, size: { height: 64, width: 128 })
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
