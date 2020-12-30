describe Hemi::Render::Texture do
  describe "abstract class" do
    it { expect(described_class).to be_abstract }

    context "inherited" do
      class TextureBased < described_class # rubocop:disable RSpec/LeakyConstantDeclaration
        def initialize; end
      end

      subject { TextureBased.new }

      it "expects #render to be implemented" do
        expect { subject.render }.to raise_error(NotImplementedError)
      end

      it "expects .bucket to be implemented" do
        expect { TextureBased.bucket }.to raise_error(NotImplementedError)
      end

      describe "#rectangle" do
        it "calls SDL2::Rect.new" do
          expect(subject).to(receive(:calculate_position))
          expect(subject).to receive(:calculate_size)
          expect(SDL2::Rect).to receive(:new)

          subject.send :rectangle
        end
      end
    end
  end
end
