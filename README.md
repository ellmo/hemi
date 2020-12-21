# Hemi

## Whatshisface
This is a _Work In Progress_ simplistic game engine based on SDL2.

Made for self-educational purposes.

## Usage

#### 1. Required libraries

Install `sdl2`, `sdl2_image`, `sdl2_mixer` and `sdl2_ttf` libraries. For MacOS you can simply `brew install` all of them.

#### 2. Using gem

Refer to [demo](https://github.com/ellmo/hemi/blob/master/demo/loop_machine_demo.rb) for now.

## Development
(`sdl2` libs are - obviously - still required)

#### 1. Install Ruby and gems

Install specific ruby version using Rbenv (`rbenv install`) or RVM (yuck)

Make sure you have Bundler gem installed for this revsion (`gem install bundler -v=1.17.3`)

And `bundle install` away.

#### 2. Update code (and bump the version)

Dont forget to `git tag` and push with `--tags option`

#### 3. Build and push to Rubygems

`gem build hemi.gemspec`

`gem push hemi-{VERSION}.gem`

And if you need to test gem installation locally:

`gem push hemi-{VERSION}.gem`


