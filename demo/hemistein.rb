require_relative "../src/hemi/engine"

class Hemistein
  prepend Hemi::Engine

  LM     = Hemi::Event::LoopMachine
  Font   = Hemi::Render::Font
  Sprite = Hemi::Render::Sprite

  def run
    LM.register(:main, loob_block, event_table)
  end

  def loob_block
    proc {
      Font[:jost_32].render("quick brown fox jumped over the lazy dog", position: [20, 20])
      Font[:jost_16].render("quick brown fox jumped over the lazy dog", position: [20, 200])

      Sprite[:gem].render(position: { y: 220, x: 20 })
      Sprite[:gem].render(position: { y: 320, x: 220 }, size: { height: 64, width: 128 })
    }
  end

  def event_table
    {
      keys: {
        escape: -> { exit },
        q: -> { exit }
      }
    }
  end
end
