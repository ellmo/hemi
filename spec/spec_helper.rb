require "pry"
require "./src/hemi/window"
require "./src/hemi/loader"

Hemi::Loader.load_tree "render"
Hemi::Loader.load_tree "input"
Hemi::Loader.load_tree "event"
