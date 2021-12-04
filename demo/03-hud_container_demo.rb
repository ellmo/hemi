require "hemi"

class HudContainerDemo
  prepend Hemi::Engine

  LM     = Hemi::Event::LoopMachine
  Font   = Hemi::Render::Font
  Sprite = Hemi::Render::Sprite
  HUD    = Hemi::Hud::Container

  def initialize
    @menu_x = 240
    @menu_y = -12
    @hint_x = 200
    @hint_y = 24
  end

  attr_reader :menu_x, :menu_y, :hint_x, :hint_y

  def run
    LM.register(:main, main_actions, main_events.merge(program_controls))
    LM.register(:menu, menu_actions, menu_events.merge(program_controls))

    HUD.new(:main, color: [200, 100, 0], anchor: :bottom_left, size: [100, 40])
  end

  def main_actions
    proc {
      Sprite[:gem].render
      display_hints
    }
  end

  def menu_actions
    proc {
      HUD[:main].render
      display_hints
    }
  end

  def main_events
    {
      space: -> { LM.switch(:menu) }
    }
  end

  def menu_events
    {
      space: -> { LM.switch(:main) }
    }
  end

  def program_controls
    {
      q: :stop!,
      f12: :debug!
    }
  end

  def display_hints
    Font[:jost_32].render("state: #{LM.current.name}", position: [menu_x, menu_y])
    Font[:jost_16].render("press [space] to change LoopState", position: [hint_x, hint_y])
  end
end

HudContainerDemo.instance.run
