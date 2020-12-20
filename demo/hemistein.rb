require_relative "../src/hemi/engine"

class Hemistein
  prepend Hemi::Engine

  def initialize
    puts "Hemistein init"
  end

  def run
    puts "Hemistein"
  end

  def loob_block
    proc {
      Hemi::Render::Font[:jost_32].render("quick brown fox jumped over the lazy dog", position: [20, 20])
      Hemi::Render::Font[:jost_16].render("quick brown fox jumped over the lazy dog", position: [20, 200])

      Hemi::Render::Sprite[:gem].render(position: { y: 220, x: 20 })
      Hemi::Render::Sprite[:gem].render(position: { y: 320, x: 220 }, size: { height: 64, width: 128 })
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
