#!/usr/bin/env ruby

require "pry"
require "./src/engine/engine"

Engine.instance.run
binding.pry
