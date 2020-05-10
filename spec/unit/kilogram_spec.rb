describe Kilogram do
  let(:instance)  { described_class.new(magnitude) }
  let(:magnitude) { 1000 }

  describe "constuctors" do
    describe ".new" do
      it "does NOT rasie an error" do
        expect { instance }.not_to raise_error
      end

      it "instantiates an object" do
        expect(instance).to be_a described_class
      end

      it "initializes with proper magnitude" do
        expect(instance.magnitude).to eq magnitude
      end
    end

    describe "shorthand .[] constructor" do
      let(:instance) { described_class[magnitude] }

      it "does NOT rasie an error" do
        expect { instance }.not_to raise_error
      end

      it "instantiates an object" do
        expect(instance).to be_a described_class
      end

      it "initializes with proper magnitude" do
        expect(instance.magnitude).to eq magnitude
      end
    end
  end

  describe "#magnitude" do
    let(:instance) { described_class[magnitude] }

    context "for 18000" do
      let(:magnitude) { 18_000 }

      it { expect(instance.magnitude).to eq magnitude }
    end

    context "for -1000" do
      let(:magnitude) { -1000 }

      it { expect(instance.magnitude).to eq magnitude }
    end
  end

  describe "#to_s" do
    let(:expected_format) { "1000.0kg" }

    it { expect(instance.to_s).to eq expected_format }
  end

  describe "#inspect" do
    let(:expected_format) { "#<Unit 1000.0:kg>" }

    it { expect(instance.inspect).to eq expected_format }
  end
end
