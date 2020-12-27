require "hemi"
require "./spec/support/fake_display"

class TestSuite
  prepend Hemi::Engine
end

RSpec.configure do |config|
  config.before(:suite) do
    # config.shared_context_metadata_behavior = :apply_to_host_groups
    config.include FakeDisplay, fake_display: true
    # config.include_context "fake display", fake_display: true
  end
end
