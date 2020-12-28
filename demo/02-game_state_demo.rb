require "hemi"

class ModKeysDemo
  prepend Hemi::Engine

  LM     = Hemi::Event::LoopMachine
  Font   = Hemi::Render::Font
  Sprite = Hemi::Render::Sprite

  def initialize
    @gem_x = 100
    @gem_y = 100
  end

  attr_reader :gem_x, :gem_y

  def run
    LM.register(:main, main_actions, main_events.merge(program_controls))
  end

  def main_actions
    proc {
      Sprite[:gem].render(position: [gem_x, gem_y])
    }
  end

  def main_events
    {
      right: -> { @gem_x += 2 },
      %i[right lshift] => -> { @gem_x += 10 },
      %i[right lshift lgui] => -> { @gem_x += 50 },

      left: -> { @gem_x -= 2 },
      %i[left lshift] => -> { @gem_x -= 10 },
      %i[left lshift lgui] => -> { @gem_x -= 50 },

      up: -> { @gem_y -= 2 },
      %i[up lshift] => -> { @gem_y -= 10 },
      %i[up lshift lgui] => -> { @gem_y -= 50 },

      down: -> { @gem_y += 2 },
      %i[down lshift] => -> { @gem_y += 10 },
      %i[down lshift lgui] => -> { @gem_y += 50 }
    }
  end

  def program_controls
    {
      escape: :stop!,
      q: :stop!,
      f12: :debug!
    }
  end
end

ModKeysDemo.instance.run
