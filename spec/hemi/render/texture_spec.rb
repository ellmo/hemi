describe Hemi::Render::Texture do
  describe "abstract class" do
    it { expect(described_class).to be_abstract }

    context "inherited" do
      class TextureBased < described_class # rubocop:disable RSpec/LeakyConstantDeclaration
        def initialize; end
      end

      it "expects #render to be implemented" do
        expect { TextureBased.new.render }.to raise_error(NotImplementedError)
      end
    end
  end
end
