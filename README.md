# Hemi

## Whatshisface
This is a _Work In Progress_ simplistic game engine based on SDL2.

Made for self-educational purposes.

## Usage

### 0. Required libraries
Install `sdl2`, `sdl2_image`, `sdl2_mixer` and `sdl2_ttf` libraries.
For MacOS you can simply `brew install` all of them.

### 1. Using the gem

#### 1.0 installation
Install the gem, either straight-up with `gem install hemi` or using Bundler:

```ruby
# Gemfile
source "https://rubygems.org"

gem "hemi"
```

#### 1.1 prepend your starting class
```ruby
require "hemi"

class Game
  prepend Hemi::Engine
end

```

#### 1.2 prepare a logic proc
This `proc` will contain logic to be performed during each rendered frame.
```ruby
Font   = Hemi::Render::Font
Sprite = Hemi::Render::Sprite

def text_logic
  proc {
    Font[:jost_32].render("quick brown fox jumped over the lazy dog", position: [20, 20])
    Font[:jost_16].render("press [space] to change LoopState", position: [20, 400])
    Font[:jost_16].render("press [q] or [esc] to quit", position: [20, 420])
    Font[:jost_16].render("press [F12] to start debug", position: [20, 440])
  }
end

def sprite_logic
  proc {
    Sprite[:gem].render(position: { y: 220, x: 20 })
    Sprite[:gem].render(position: { y: 320, x: 220 }, size: { height: 64, width: 128 })
    Font[:jost_16].render("press [space] to change LoopState", position: [20, 400])
    Font[:jost_16].render("press [q] or [esc] to quit", position: [20, 420])
    Font[:jost_16].render("press [F12] to start debug", position: [20, 440])
  }
end
```

#### 1.3 prepare an {event:action} hash
```ruby
LM = Hemi::Event::LoopMachine

def text_events
  {
    space: -> { LM.switch(:image) },
    escape: :stop!,
    q:      :stop!,
    f12:    :debug!
  }
end

def sprite_events
  {
    space: -> { LM.switch(:text) },
    escape: :stop!,
    q:      :stop!,
    f12:    :debug!
  }
end
```

#### 1.4 register Loop Machine states
```ruby
def run
  LM.register(:text, text_logic, text_events)
  LM.register(:image, sprite_logic, sprite_events)
end
```

#### 1.5 and run it
```ruby
Game.instance.run
```
