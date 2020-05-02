describe Unit do
  describe ".new" do
    it "rasies an error" do
      expect { described_class.new(1) }.to raise_error(NotImplementedError)
    end
  end
end
