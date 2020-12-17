describe Hemi::Render::Sprite do
  shared_examples "sprite initialization and registration" do
    before { described_class.purge! }

    context "sprite NOT yet loaded" do
      it "registers new sprite" do
        expect { subject }
          .to change(described_class.sprites, :count)
          .by(1)
      end
    end

    context "sprite already loaded" do
      before { described_class.new sprite_name }

      it "does NOT register new sprite" do
        expect { subject }
          .not_to change(described_class.sprites, :count)
      end
    end
  end

  describe "class methods" do
    describe "[]" do
      subject { described_class[sprite_name] }

      let(:sprite_name) { :gem }

      it { is_expected.to be_a described_class }

      include_examples "sprite initialization and registration"
    end
  end

  describe "#new" do
    subject { described_class.new(sprite_name) }

    let(:sprite_name) { :gem }

    include_examples "sprite initialization and registration"
  end
end
