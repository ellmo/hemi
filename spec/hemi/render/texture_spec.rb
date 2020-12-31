describe Hemi::Render::Texture do
  describe "abstract class" do
    it { expect(described_class).to be_abstract }
  end

  context "when inherited" do
    class TextureHeir < described_class # rubocop:disable RSpec/LeakyConstantDeclaration
      def initialize; end
    end

    subject { TextureHeir.new }

    it "expects #render to be implemented" do
      expect { subject.render }.to raise_error(NotImplementedError)
    end

    it "expects .bucket to be implemented" do
      expect { TextureHeir.bucket }.to raise_error(NotImplementedError)
    end

    describe "#rectangle" do
      it "calls SDL2::Rect.new" do
        expect(subject).to(receive(:calculate_position))
        expect(subject).to receive(:calculate_size)
        expect(SDL2::Rect).to receive(:new)

        subject.method(:rectangle).call
      end
    end

    describe "position and size calculations" do
      let(:heir)        { TextureHeir.new }
      let(:texture_dbl) { double("Texture", h: 100, w: 200) }

      before { allow(heir).to receive(:texture).and_return(texture_dbl) }

      describe "#calculate_position" do
        subject { heir.method(:calculate_position).call(args) }

        context "with array" do
          let(:args) { [20, 30] }

          it "returns a Position struct" do
            expect(subject).to eq(Position.new(x: 20, y: 30))
          end
        end

        context "with hash" do
          let(:args) { { y: 35, x: 22 } }

          it "returns a Position struct" do
            expect(subject).to eq(Position.new(x: 22, y: 35))
          end
        end

        context "with nil" do
          let(:args) { nil }

          it "returns a Position struct" do
            expect(subject).to eq(Position.new(x: 0, y: 0))
          end
        end

        context "with bad arguments" do
          let(:args) { 2 }

          it "returns a Size struct" do
            expect { subject }.to raise_error(ArgumentError, TextureHeir::ERR__INVALID_POSITION)
          end
        end
      end

      describe "#calculate_size" do
        subject { heir.method(:calculate_size).call(args) }

        context "with array" do
          let(:args) { [80, 60] }

          it "returns a Size struct" do
            expect(subject).to eq(Size.new(height: 80, width: 60))
          end
        end

        context "with hash" do
          let(:args) { { height: 200, width: 320 } }

          it "returns a Size struct" do
            expect(subject).to eq(Size.new(height: 200, width: 320))
          end
        end

        context "with nil" do
          let(:args) { nil }

          it "returns a Size struct" do
            expect(subject).to eq(Size.new(height: texture_dbl.h, width: texture_dbl.w))
          end
        end
      end
    end
  end
end
