module Hemi::Event
  module Pattern
    class Key
      MATCHED_EVENT = "SDL2::Event::KeyDown".freeze

      ALLOWED_TYPES = %i[up down].freeze
      MOD_KEYS = %i[lshift rshift lctrl rctrl lalt ralt lgui rgui].freeze

      def initialize(key, type: :down, mods: nil)
        @type = type.to_s
        @key  = key.to_s
        @mods = mods
        key_to_scancode
        mods_to_modcode
      end

      attr_reader :type, :key, :mods, :scancode, :modcode

      def hash
        KeyPattern.new(scancode, modcode).hash
      end

      def inspect
        "#<#{self.class}:#{hash} key=#{key} mods=#{mods.join(', ')}>"
      end

      def key_to_scancode
        @scancode = SDL2::Key::Scan.const_get(key.upcase)
      end

      def mods_to_modcode
        @modcode = mods&.sum do |modkey|
          SDL2::Key::Mod.const_get(modkey.upcase)
        end || 0
      end
    end
  end
end
