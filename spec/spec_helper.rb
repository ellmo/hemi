require "pry"
require "./src/helpers"
require "./src/hemi/window"
require "./src/hemi/loader"

Hemi::Loader.load_tree "render"
Hemi::Loader.load_tree "input"
Hemi::Loader.load_tree "event"
