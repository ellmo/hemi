describe Hemi::Render::Font, fake_display: true do
  shared_examples "font initialization and registration" do
    before { described_class.purge! }

    context "font NOT yet loaded" do
      it "registers new font" do
        expect { subject }
          .to change(described_class.fonts, :count)
          .by(1)
      end
    end

    context "font already loaded" do
      before { described_class.new font_name }

      it "does NOT register new font" do
        expect { subject }
          .not_to change(described_class.fonts, :count)
      end
    end
  end

  shared_examples "font init error handling" do
    before { described_class.purge! }

    context "font NOT yet loaded" do
      it "registers new font" do
        expect { subject }
          .to change(described_class.fonts, :count)
          .by(1)
      end
    end

    context "font already loaded" do
      before { described_class.new font_name }

      it "does NOT register new font" do
        expect { subject }
          .not_to change(described_class.fonts, :count)
      end
    end
  end

  describe "class methods" do
    describe "[]" do
      subject { described_class[font_name] }

      let(:font_name) { :jost_16 }

      it { is_expected.to be_a described_class }

      include_examples "font initialization and registration"
    end
  end

  describe "#new" do
    subject { described_class.new(font_name) }

    let(:font_name) { :jost_16 }

    include_examples "font initialization and registration"
  end
end
