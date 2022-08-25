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
    LM.register(:gem, gem_actions, menu_events.merge(program_controls))

    HUD.new(:red, color: [255, 80, 80], anchor: :center, size: [200, 200])
    HUD.new(:green, color: [80, 255, 80], anchor: :top_left, size: [150, 150], parent: :red)
    HUD.new(:blue, color: [80, 80, 255], anchor: :bottom_right, size: [100, 100], parent: :green)
  end

  def main_actions
    proc {
      HUD[:red].render
      HUD[:green].render
      HUD[:blue].render

      display_hints
    }
  end

  def gem_actions
    proc {
      Sprite[:gem].render
      display_hints
    }
  end

  def main_events
    {
      space: -> { LM.switch(:gem) }
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
