describe Hemi::Render::Image do
  describe "eigenclass" do
    describe "@textures collection" do
      describe "[]" do
        subject { described_class[param] }

        context "texture not yet loaded" do
          let(:param) { :gem }

          it { expect(subject).to be_a SDL2::Texture }
        end
      end

      describe "[]=" do
      end
    end
  end
end
