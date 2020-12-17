describe Hemi::Render::Image do
  describe "class methods" do
    let(:image_spy) { class_spy(described_class) }

    describe "[]" do
      subject { described_class[image_name] }

      let(:image_name) { :gem }

      before { described_class.purge! }

      it { is_expected.to be_a SDL2::Texture }

      context "image NOT yet loaded" do
        it "calls .register" do
          stub_const(described_class.to_s, image_spy)
          subject
          expect(image_spy).to have_received(:register)
        end
      end

      context "image already loaded" do
        before { described_class.register image_name }

        it "does NOT register new image" do
          stub_const(described_class.to_s, image_spy)
          subject
          expect(image_spy).not_to have_received(:register)
        end
      end
    end
  end
end
