module Hemi::Event
  module KeyHandler
    MOD_KEYS = %i[LSHIFT RSHIFT LCTRL RCTRL LALT RALT LGUI RGUI].freeze

    MOD_MAPPINGS = MOD_KEYS.each_with_object({}) do |key, hsh|
      scancode = SDL2::Key::Mod.const_get(key)
      hsh[key] = scancode
    end

    def register_events!(events)
      @events = event_hash(events)
    end

    def event_hash(events)
      events.each_with_object({}) do |(input, action), hsh|
        key, mod = if input.is_a? Array
                     keys = input.map(&:upcase)
                     key  = keys.shift
                     mods = keys.map { |x| MOD_MAPPINGS[x.upcase] }
                     [key, mods.sum]
                   else
                     [input.upcase, 0]
                   end

        hsh[[SDL2::Key::Scan.const_get(key), mod]] = action
      end
    end
  end
end
