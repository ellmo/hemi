describe Thingamabob do
  let(:instance) { described_class.new }

  describe "constructor" do
    before { allow(Whatchamacallit).to receive(:new) }

    it "initializes a Whatchamacallit object" do
      instance
      expect(Whatchamacallit).to have_received(:new)
    end
  end

  describe "#start" do
    it do
      expect do
        instance.start
      end.to output(anything).to_stdout
    end
  end
end
