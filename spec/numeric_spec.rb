describe Numeric do
  describe "#kg" do
    subject { 1000.kg }

    it "returns a Kilogram instnace" do
      expect(subject).to be_a Kilogram
    end
  end
end
