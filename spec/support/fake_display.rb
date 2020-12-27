require_relative "fake_window"
require_relative "fake_renderer"
require_relative "fake_texture"

module FakeDisplay
  def self.included(base)
    base.around do |ex|
      ex.example_group.prepend_before do
        allow(SDL2::Window)
          .to receive(:create)
          .and_return(FakeWindow.instance)

        allow(FakeWindow.instance)
          .to receive(:create_renderer)
          .and_return(FakeRenderer.instance)

        allow(FakeRenderer.instance)
          .to receive(:load_texture)
          .and_return(FakeTexture.instance)
      end

      ex.run
    end
  end
end
