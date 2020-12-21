require "pry"
require_relative "../src/hemi/engine"

class TestSuite
  prepend Hemi::Engine
end
