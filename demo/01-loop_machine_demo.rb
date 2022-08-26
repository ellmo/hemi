require "hemi"

class LoopMachineDemo
  prepend Hemi::Engine

  LM     = Hemi::Event::LoopMachine
  Font   = Hemi::Render::Font
  Sprite = Hemi::Render::Sprite
  Box    = Hemi::Render::Box

  def run
    LM.register(:text, text_logic, text_events)
    LM.register(:image, sprite_logic, sprite_events)
    LM.register(:box, box_logic, box_events)

    #Box.new(:redbox, color: [255, 0, 0], size: [32, 32])
  end

  def text_logic
    proc {
      Font[:jost_32].render("quick brown fox jumped over the lazy dog", position: [20, 20])
      hint_logic
    }
  end

  def sprite_logic
    proc {
      Sprite[:gem].render(position: { y: 220, x: 20 })
      Sprite[:gem].render(position: { y: 320, x: 220 }, size: { height: 64, width: 128 })
      hint_logic
    }
  end

  def box_logic
    proc {
      Box[:redbox].render(position: Position.new(y: 220, x: 20))
      hint_logic
    }
  end

  def hint_logic
    Font[:jost_16].render("press [space] to change LoopState", position: [20, 400])
    Font[:jost_16].render("press [q] or [esc] to quit", position: [20, 420])
    Font[:jost_16].render("press [F12] to start debug", position: [20, 440])
  end

  def text_events
    {
      space: -> { LM.switch(:image) },
      escape: :stop!,
      q: :stop!,
      f12: :debug!
    }
  end

  def sprite_events
    {
      space: -> { LM.switch(:box) },
      escape: :stop!,
      q: :stop!,
      f12: :debug!
    }
  end

  def box_events
    {
      space: -> { LM.switch(:text) },
      escape: :stop!,
      q: :stop!,
      f12: :debug!
    }
  end
end

LoopMachineDemo.instance.run
