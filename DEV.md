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


